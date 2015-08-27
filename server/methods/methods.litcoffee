# Meteor methods file


    Meteor.methods(
        getResults: (id) -> Results.findOne({ _id: id })

        getPoliticalParties: -> PoliticalParties.find().fetch()

        getPersonalQuestions: -> PersonalQuestions.find({}, { sort: { order: 1 } }).fetch()

        getPoliticalQuestions: -> PoliticalQuestions.find({}, { sort: { number: 1 } }).fetch()

        getTopics: -> Topics.find().fetch()

        sendResults: (results) ->

            Schemas.Result.clean(results)

            isValid = Results.simpleSchema().namedContext("Results").validate(results, { modifier: false })

            unless isValid
                console.error(Results.simpleSchema().namedContext("Results").invalidKeys())
                throw new Meteor.Error("result-validation", "Results are incorrect")

Need to calculate results based on the answered questions

            computeResults = () ->

Get info altogether

                politicalParties = _.pluck(PoliticalParties.find().fetch(), 'id')
                topics = _.pluck(Topics.find().fetch(), 'id')
                questionsById = {}

Build question map by id for efficiency

                topicQuestionCountMap = {}

                topicQuestionCountMap[topic] = 0 for topic in topics

                for question in PoliticalQuestions.find().fetch()
                    questionsById[question._id] = question
                    ++topicQuestionCountMap[question.topic]

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

Get every answer and sum the correspondant score for the party to the topic

                    for answer in results.political.basicAnswers
                        question = questionsById[answer.questionId]

                        partyRow =  _.find(question.answerResemblanceToPartyMatrix, (artp) -> artp.party is politicalParty).resemblanceToAnswers

                        questionScore = if answer.answer is PoliticalQuestions.NO_ANSWER then PoliticalQuestions.NO_ANSWER_POINTS else partyRow[PoliticalQuestions.BASIC_QUESTION_OPTIONS.indexOf(answer.answer)]
                        topicInfoMap[question.topic].score += questionScore

                    politicalPartyRawScoreValue = 0

Sum the score of the party in every topic to the total score and to the topic score and push it to its info arrays

                    for topic, info of topicInfoMap
                        partyScoreInTopic = info.score/(topicQuestionCountMap[topic]*PoliticalQuestions.QUESTION_COUNT)
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