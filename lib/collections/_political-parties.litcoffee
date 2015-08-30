# Political parties collection and schema

    @PoliticalParties = new Mongo.Collection('PoliticalParties')


    Schemas.PoliticalParties = new SimpleSchema(
        _id:
            type: String
            min: 1
            max: 30

        color:
            type: String
            regEx: /^#(?:[0-9a-fA-F]{3}){1,2}$/

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

    PoliticalParties.attachSchema(Schemas.PoliticalParties)