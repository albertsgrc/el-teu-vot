# Personal Questions collection and schema

    @PersonalQuestions = new Mongo.Collection('PersonalQuestions')

    PersonalQuestions.QUESTION_TYPES = ["button", "input"]

    Schemas.PersonalQuestion = new SimpleSchema(
        id:
            type: String
            min: 1
            max: 50
            unique: true
            index: true

        order:
            type: Number
            unique: true

        mandatory:
            type: Boolean

        type:
            type: String
            max: 50
            min: 1
            allowedValues: PersonalQuestions.QUESTION_TYPES

        options:
            type: [String]
            optional: true
            minCount: 1
            custom: ->
                unless @field("type").value isnt "button" or @isSet
                    return "Options field is required for button-type personal question"

        validate:
            type: String
            optional: true
            min: 1
            custom: ->
                unless @field("type").value isnt "input" or @isSet
                    return "Validate field is required for input-type personal question"

        errorMessageId:
            type: String
            optional: true
            custom: ->
                unless @field("type").value isnt "input" or @isSet
                    return "Error Message Id field is required for input-type personal question"

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

    PersonalQuestions.attachSchema(Schemas.PersonalQuestion)