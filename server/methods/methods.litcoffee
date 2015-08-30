# Meteor methods file

    isOlderThan = (minutesOld, date) ->
        now = new Date
        return now - date >= minutesOld*60000

    Meteor.methods(
        getResults: (id) ->
            Results.findOne({ _id: id }, { fields: { partyCoincidence: 1, topicAndPartyCoincidence: 1, "political.ideologicalLocation": 1, "political.nationalLocation": 1, "political.topicOrder": 1 } })

        getPoliticalParties: ->
            PoliticalParties.find({}, { fields: { createdAt: 0, updatedAt: 0 } }).fetch()

        getPersonalQuestions: ->
            PersonalQuestions.find({}, { fields: { createdAt: 0, updatedAt: 0 }, sort: { order: 1 } }).fetch()

        getPoliticalQuestions: ->
            PoliticalQuestions.find({ currentlyActive: true }, { sort: { number: 1 }, fields: { answerResemblanceToPartyMatrix: 0, currentlyActive: 0, createdAt: 0, updatedAt: 0 } }).fetch()

        getTopics: ->
            Topics.find({}, { fields: { createdAt: 0, updatedAt: 0 } }).fetch()

        sendResults: (results) ->
            possiblePreviousSavedResult = Results.findOne({ userId: results.userId }, { fields: { _id: 1, createdAt: 1 }, sort: { createdAt: -1 } })

            if possiblePreviousSavedResult? and not isOlderThan(60, possiblePreviousSavedResult.createdAt)
                return possiblePreviousSavedResult._id

            Schemas.Result.clean(results)

            isValid = Results.simpleSchema().namedContext("Results").validate(results, { modifier: false })

            unless isValid
                console.error(Results.simpleSchema().namedContext("Results").invalidKeys())
                throw new Meteor.Error("result-validation", "Results are incorrect")

Need to calculate results based on the answered questions

            computeResults = () ->
                questionsById = {}

Get info altogether

                politicalParties = _.pluck(PoliticalParties.find().fetch(), '_id')
                topics = _.pluck(Topics.find().fetch(), '_id')

Build question map by id for efficiency

                politicalQuestions = PoliticalQuestions.find({ type: 'basic' }).fetch()

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

            Schemas.Result.clean(results)

            isValid = Results.simpleSchema().namedContext().validateOne(results, 'partyCoincidence', { modifier: false })

            unless isValid
                console.error(Results.simpleSchema().namedContext("Results").invalidKeys())
                throw new Meteor.Error("result-computation-validation", "Computed results are incorrect") unless isValid

            isValid = Results.simpleSchema().namedContext().validateOne(results, 'topicAndPartyCoincidence', { modifier: false })

            unless isValid
                console.error(Results.simpleSchema().namedContext("Results").invalidKeys())
                throw new Meteor.Error("result-computation-validation", "Computed results are incorrect") unless isValid

            return Results.insert(results, { validate: false })
    )