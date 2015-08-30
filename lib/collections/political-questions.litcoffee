# Political Questions collection and schema

    @PoliticalQuestions = new Mongo.Collection('PoliticalQuestions')

    PoliticalQuestions.QUESTION_TYPES = ["basic"
                                         "ideologicalLocation"
                                         "nationalLocation"
                                         "topicSort"]

If this array changes, then the Party coincidence - answer scoring matrix should also change

    PoliticalQuestions.BASIC_QUESTION_OPTIONS = ["ted"
                                                  "ed"
                                                  "nand"
                                                  "da"
                                                  "tda"
                                                  "nsnc"]

    PoliticalQuestions.QUESTION_COUNT = PoliticalQuestions.BASIC_QUESTION_OPTIONS.length

    PoliticalQuestions.VALID_QUESTION_COUNT = PoliticalQuestions.QUESTION_COUNT - 1

    PoliticalQuestions.NO_ANSWER = "nsnc"

    PoliticalQuestions.MAX_ANSWER_VALUE = 5

    throw new Meteor.Error("Max answer value must be != 0") if PoliticalQuestions.MAX_ANSWER_VALUE is 0

    Schemas.AnswerResemblanceToParty = new SimpleSchema(
        party:
            type: String
            min: 1
            max: 30

        resemblanceToAnswers:
            type: [Number]

            minCount: PoliticalQuestions.VALID_QUESTION_COUNT

            maxCount: PoliticalQuestions.VALID_QUESTION_COUNT

            decimal: true

            custom: ->

Again we substract one because of the Ns/Nc option

                length = PoliticalQuestions.VALID_QUESTION_COUNT
                unless length is @value.length and _.max(@value) is PoliticalQuestions.MAX_ANSWER_VALUE
                    return "Incorrect attribute value, doesn't have #{length} numbers or exceeds max value #{PoliticalQuestions.MAX_ANSWER_VALUE}"
    )

    Schemas.PoliticalQuestion = new SimpleSchema(
        number:
            type: Number
            min: 1
            unique: true
            index: true

        type:
            type: String
            max: 40
            allowedValues: PoliticalQuestions.QUESTION_TYPES

        topic:
            type: String
            optional: true
            custom: ->
                if @field("type").value is "basic"
                    return "Topic field is required for basic-type political questions" if not @isSet
                    return "Incorrect topic value" unless @value in _.pluck(Topics.find().fetch(), '_id')

        answerResemblanceToPartyMatrix:
            type: [Schemas.AnswerResemblanceToParty]
            optional: true
            custom: ->
                if @field("type").value is "basic"
                    return "Answer Resemblance Matrix field is required for basic-type political questions"  if not @isSet

                    politicalParties = _.pluck(PoliticalParties.find().fetch(), '_id')
                    partiesIncluded = _.pluck(@value, 'party')
                    return "Some political party was not included in the matrix or there were invalid or extra ones" unless _.intersection(partiesIncluded, politicalParties).length is politicalParties.length and politicalParties.length is partiesIncluded.length

        currentlyActive:
            type: Boolean
            autoValue: -> true

        createdAt:
            type: Date
            autoValue: ->
                if @isInsert then return new Date
                else if @isUpsert then return { $setOnInsert: new Date }
                else @unset()

        updatedAt:
            type: Date
            autoValue: ->
                if @isUpdate then return new Date
            denyInsert: true
            optional: true
    )

    PoliticalQuestions.attachSchema(Schemas.PoliticalQuestion)

    PoliticalQuestions.helpers({
        options: ->
            switch @type
                when "basic"
                    return PoliticalQuestions.BASIC_QUESTION_OPTIONS
                when "topicSort" then return Topics.find().fetch()
                when "ideologicalLocation", "nationalLocation" then return RANGE_QUESTION_RANGE

    })