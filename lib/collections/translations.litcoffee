# Translations collection and schema

    @Translations = new Mongo.Collection('Translations')

    LANGUAGES = ["ca", "es"]

    Schemas.LanguageTranslation = new SimpleSchema(
        lang:
            type: String
            allowedValues: LANGUAGES

        value:
            type: String
            min: 1
    )

    Schemas.Translation = new SimpleSchema(
        _id:
            type: String
            min: 1
            max: 200

        type:
            type: String
            min: 1
            max: 200

        translations:
            type: [Schemas.LanguageTranslation]

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

    Translations.attachSchema(Schemas.Translation)