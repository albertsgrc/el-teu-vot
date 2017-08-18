# Meteor methods file

    jsZip = Meteor.npmRequire('jszip')

    isOlderThan = (minutesOld, date) ->
        now = new Date
        return now - date >= minutesOld*60000

    toCsv = (results) ->
        personalQuestions = _cc.PersonalQuestions.full
        topics = _cc.Topics.full
        translations = _cc.Translations.client

        csv = ""
        DELIMITER = ";"

        pqOrderById = {}
        for question in personalQuestions
            pqOrderById[question._id] = question.order

        localeOffsetInHours = ((new Date()).getTimezoneOffset() + 120)/60

        translate = (s) ->
            tr = translations[s]
            if tr
                if Array.isArray(tr) then tr[0] else tr
            else s

        addHeaders = ->
            csv += "Id"
            csv += "#{DELIMITER}Pregunta #{question}" for question in [1..23]
            csv += "#{DELIMITER}Ubicació ideològica#{DELIMITER}Ubicació nacional"
            csv += "#{DELIMITER}#{translate(topic._id)}" for topic in topics
            csv += "#{DELIMITER}#{translate(question._id + "Export")}" for question in personalQuestions.sort((a, b) -> a.order - b.order)
            csv += "#{DELIMITER}Data"

        addData = ->
            for result, i in results
                csv += "\n#{result._id}"

                for answer in result.political.basicAnswers.sort((a, b) -> b.number - a.number)
                    csv += "#{DELIMITER}#{answer.answer}"

                csv += "#{DELIMITER}#{result.political.ideologicalLocation}#{DELIMITER}#{result.political.nationalLocation}"

                for topic in topics
                    csv += "#{DELIMITER}#{Topics.TOPIC_WEIGHT_BY_ORDER_INDEX_STRING[result.political.topicOrder.indexOf(topic._id)]}"

                for answer in result.personal.answers.sort((a, b) -> pqOrderById[a.questionId] - pqOrderById[b.questionId])
                    csv += "#{DELIMITER}"
                    csv += "#{translate(answer.answer)}" if answer.answer

                date = new Date(result.createdAt)
                date.setUTCHours(date.getUTCHours() + localeOffsetInHours)

                pad = (n) -> if n < 10 then '0' + n else n

                csv += "#{DELIMITER}#{pad(date.getDate())}/#{pad(date.getMonth() + 1)}/#{date.getFullYear()} #{pad(date.getHours())}:#{pad(date.getMinutes())}:#{pad(date.getSeconds())}.#{(date.getMilliseconds()/ 1000).toFixed(3).slice(2, 5)}"

        addHeaders()
        addData()

        csv

    Meteor.methods(
        getResult: -> Results.findOne({}, { fields: { _id: 1 } })?._id

        getAllResults: ->
            if @userId? and @userId is Meteor.users.findOne({ username: 'admin' })._id
                csv = toCsv(Results.find({}, { fields: { _id: 1, political: 1, personal: 1, createdAt: 1 }, sort: { createdAt: 1 } }).fetch())
                zip = new jsZip()
                zip.file('resultats.csv', csv)

                zip.generate({ type: "base64", compression: "DEFLATE", compressionOptions: { level: 9 } })
            else
                throw new Meteor.Error("AUTH_ERROR", "NO_USER")

        getResults: (id) ->
            Results.findOne({ _id: id }, { fields: { partyCoincidence: 1, topicAndPartyCoincidence: 1, "political.ideologicalLocation": 1, "political.nationalLocation": 1, "political.topicOrder": 1 } })

        getPoliticalParties: -> _cc.PoliticalParties.client

        getPersonalQuestions: -> _cc.PersonalQuestions.client

        getPoliticalQuestions: -> _cc.PoliticalQuestions.client

        getTopics: -> _cc.Topics.client

        getTranslations: -> _cc.Translations.client

        updateCollectionCache: (collections...) -> CollectionCache.update(collections...)

        sendResults: (results) ->
            possiblePreviousSavedResult = Results.findOne({ sessionId: results.sessionId }, { fields: { _id: 1, createdAt: 1 }, sort: { createdAt: -1 } })

            if possiblePreviousSavedResult? and not isOlderThan(60, possiblePreviousSavedResult.createdAt)
                return possiblePreviousSavedResult._id

            politicalParties = _.pluck(_cc.PoliticalParties.client, '_id')
            topics = _.pluck(_cc.Topics.client, '_id')
            politicalQuestions = _.where(_cc.PoliticalQuestions.full, { type: 'basic' })
            personalQuestionsArray = _cc.PersonalQuestions.full

Need to calculate results based on the answered questions

            computeResults = () ->
                questionsById = {}

Build question map by id for efficiency

                for question in politicalQuestions
                    questionsById[question._id] = question

Initialize result properties

                results.partyCoincidence = []
                results.topicAndPartyCoincidence = []

Initialize all topic coincidence party arrays

                for topic in topics
                    results.topicAndPartyCoincidence.push(
                        topic: topic
                        values: []
                    )

Store the weight assigned by the user to the topic indexed in the map

                topicWeightMap = {}

The position of the topic in the array indicates the order (weight) assigned to the topic

                for topic, i in results.political.topicOrder
                    topicWeightMap[topic] = Topics.TOPIC_WEIGHT_BY_ORDER_INDEX[i]


We repeat the score calculation process for every political party

                for politicalParty in politicalParties
                    topicInfoMap = {}

Initialize map to gather information about the score of the party in every topic and the number of questions with valid answers (not NS/NC)

                    for topic in topics
                        topicInfoMap[topic] =
                            score: 0
                            validAnswerCount: 0

Get every answer and sum the correspondant score for the party to the topic

                    for answer in results.political.basicAnswers
                        question = questionsById[answer.questionId]

                        partyRow =  _.find(question.answerResemblanceToPartyMatrix, (artp) -> artp.party is politicalParty).resemblanceToAnswers

                        unless answer.answer is PoliticalQuestions.NO_ANSWER
                            questionScore = partyRow[PoliticalQuestions.BASIC_QUESTION_OPTIONS.indexOf(answer.answer)]
                            topicInfoMap[question.topic].score += questionScore
                            ++topicInfoMap[question.topic].validAnswerCount

                    politicalPartyRawScoreValue = 0

Sum the score of the party in every topic to the total score and to the topic score and push it to its info arrays

                    for topic, info of topicInfoMap
                        partyScoreInTopic = if topicInfoMap[topic].validAnswerCount is 0 then 0 else info.score/(topicInfoMap[topic].validAnswerCount*PoliticalQuestions.MAX_ANSWER_VALUE)
                        politicalPartyRawScoreValue += (partyScoreInTopic)*topicWeightMap[topic]
                        topicPartyArray = _.find(results.topicAndPartyCoincidence, (elem) -> elem.topic is topic)

                        topicPartyArray.values.push(
                            party: politicalParty
                            value: partyScoreInTopic
                        )


                    results.partyCoincidence.push(
                        party: politicalParty
                        value: politicalPartyRawScoreValue
                    )

            computeResults()

            ###
            Schemas.Result.clean(results)

            isValid = Results.simpleSchema().namedContext().validateOne(results, 'partyCoincidence', { modifier: false, extendedCustomContext: validationData })

            unless isValid
                console.error(Results.simpleSchema().namedContext("Results").invalidKeys())
                throw new Meteor.Error("result-computation-validation", "Computed results are incorrect") unless isValid

            isValid = Results.simpleSchema().namedContext().validateOne(results, 'topicAndPartyCoincidence', { modifier: false, extendedCustomContext: validationData })

            unless isValid
                console.error(Results.simpleSchema().namedContext("Results").invalidKeys())
                throw new Meteor.Error("result-computation-validation", "Computed results are incorrect") unless isValid
            ###

            personalQuestions = {}
            for question in personalQuestionsArray
                personalQuestions[question._id] = question

            validationData = {
                politicalParties: politicalParties
                topics: topics
                politicalQuestions: politicalQuestions
                personalQuestions: personalQuestions
            }

            ret = Results.insert(results, { extendedCustomContext: validationData })

            return ret
    )