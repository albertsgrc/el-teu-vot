# Translations collection and schema

    @Translations = new Mongo.Collection('Translations')

    Schemas.Translations = new SimpleSchema(
        ca:
            type: String
        es:
            type: String

    )

    Schemas.Translation = new SimpleSchema(
        id:
            type: String
            min: 1
            max: 200

        translations:
            type: Schemas.Translations

    )

    Translations.attachSchema(Schemas.Translation)