# Quiz results collection and schema

    @Results = new Mongo.Collection('Results')

    Schemas.BasicPoliticalQuestionAnswer = new SimpleSchema(
        questionId:
            type: String
            regEx: SimpleSchema.RegEx.Id
            custom: -> return "The question doesn't exist" unless PoliticalQuestions.findOne({ _id: @value })?

        number:
            type: Number

        answer:
            type: String
            custom: -> return "The answer value is incorrect" unless @value in PoliticalQuestions.BASIC_QUESTION_OPTIONS

    )

    Schemas.PoliticalResult = new SimpleSchema(
        basicAnswers:
            type: [Schemas.BasicPoliticalQuestionAnswer]

            custom: ->
                basicActivePoliticalQuestionsIds = _.pluck(PoliticalQuestions.find({ currentlyActive: true, type: 'basic' }).fetch(), '_id')
                answersIds = _.pluck(@value, 'questionId')
                return "The result lacks some basic political questions or has extra or incorrect ones" unless _.intersection(basicActivePoliticalQuestionsIds, answersIds).length is basicActivePoliticalQuestionsIds.length and basicActivePoliticalQuestionsIds.length is answersIds.length

        ideologicalLocation:
            type: Number
            min: RANGE_QUESTION_RANGE[0]
            max: RANGE_QUESTION_RANGE[RANGE_QUESTION_RANGE.length - 1]
            decimal: true

        nationalLocation:
            type: Number
            min: RANGE_QUESTION_RANGE[0]
            max: RANGE_QUESTION_RANGE[RANGE_QUESTION_RANGE.length - 1]
            decimal: true

        topicOrder:
            type: [String]
            custom: ->
                topics = _.pluck(Topics.find().fetch(), '_id')
                return "Some topic is missing or is incorrect or there are extra topics" unless _.intersection(@value, topics).length is topics.length and topics.length is @value.length
    )

    Schemas.PersonalAnswer = new SimpleSchema(
        questionId:
            type: String
            min: 1
            max: 50
            custom: -> return "The question doesn't exist" unless PersonalQuestions.findOne({ _id: @value })?


        answer:
            type: String
            optional: true
            custom: ->
                question = PersonalQuestions.findOne({ _id: @siblingField("questionId").value })

                return "The personal question doesn't exist" unless question?

                return unless question.mandatory

                if question.type is "button"
                    return "The personal question answer is incorrect, should be one of #{question.options}" unless @value in question.options
                else if question.type is "input"
                    regexp = new RegExp(question.validate)
                    return "The personal question answer is incorrect, regex validator #{question.validate}" unless regexp.test(@value)
    )

    Schemas.PersonalResult = new SimpleSchema(
        answers:
            type: [Schemas.PersonalAnswer]
            custom: ->
                personalQuestionsIds = _.pluck(PersonalQuestions.find({}).fetch(), '_id')
                answersQuestionsIds = _.pluck(@value, 'questionId')
                return "Some question's answer is missing or there are extra or incorrect ones" unless _.intersection(personalQuestionsIds, answersQuestionsIds).length is personalQuestionsIds.length
    )

    Schemas.PartyCoincidence = new SimpleSchema(
        party:
            type: String
            custom: ->
                return "Party name is incorrect" unless @value in _.pluck(PoliticalParties.find().fetch(), '_id')

        value:
            type: Number
            decimal: true
            max: 1
            min: 0
    )

    Schemas.TopicAndPartyCoincidence = new SimpleSchema(
        topic:
            type: String
            custom: ->
                return "Topic is incorrect" unless @value in _.pluck(Topics.find().fetch(), '_id')

        values:
            type: [Schemas.PartyCoincidence]
            custom: ->
                actualPartiesIds = _.pluck(@value, 'party')
                partiesIds = _.pluck(PoliticalParties.find().fetch(), '_id')
                return "Some political party is missing or there are extra or incorrect ones" unless _.intersection(partiesIds, actualPartiesIds).length is partiesIds.length and partiesIds.length is actualPartiesIds.length
    )

    Schemas.Result = new SimpleSchema(
        sessionId:
            type: String
            index: true

        political:
            type: Schemas.PoliticalResult

        personal:
            type: Schemas.PersonalResult

        partyCoincidence:
            optional: true

            type: [Schemas.PartyCoincidence]

            custom: ->
                if @isSet
                    actualPartiesIds = _.pluck(@value, 'party')
                    partiesIds = _.pluck(PoliticalParties.find().fetch(), '_id')
                    return "Some political party is or there are extra or incorrect ones" unless _.intersection(partiesIds, actualPartiesIds).length is partiesIds.length and partiesIds.length is actualPartiesIds.length

        topicAndPartyCoincidence:
            optional: true

            type: [Schemas.TopicAndPartyCoincidence]

            custom: ->
                if @isSet
                    actualTopicsIds = _.pluck(@value, 'topic')
                    topicsIds = _.pluck(Topics.find().fetch(), '_id')
                    return "Some topic is missing or there are extra or incorrect ones" unless _.intersection(actualTopicsIds, topicsIds).length is topicsIds.length and topicsIds.length is actualTopicsIds.length

        createdAt:
            type: Date
            autoValue: ->
                if @isUpsert then return { $setOnInsert: new Date }
                else if @isInsert then return new Date
                else return new Date

        updatedAt:
            type: Date
            autoValue: ->
                if @isUpdate then return new Date
            denyInsert: true
            optional: true
    )

    Results.attachSchema(Schemas.Result)