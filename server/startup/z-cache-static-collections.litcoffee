
    @_cc = {}

    class _CollectionCache
        refreshCollection = (collection) ->
            if collection? and typeof collection is "string"
                collection = @collections[collection]
                return unless collection?

                collection.full = collection.update()

                if collection.clientTransform
                    collection.client = collection.clientTransform(collection.full)
                else
                    collection.client = _.map(collection.full, (elem) ->
                        if collection.include then _.pick(elem, collection.include)
                        else if collection.exclude then _.omit(elem, collection.exclude)
                        else elem
                    )

        refreshAllCollections = ->
            refreshCollection(collection) for collection of @collections

        constructor: (@collections, shortcutObject) ->
            refreshCollection = _.bind(refreshCollection, @)
            refreshAllCollections = _.bind(refreshAllCollections, @)

            refreshAllCollections()

            for collection, value of @collections
                shortcutObject[collection] =
                    client: value.client
                    full: value.full

        update: (collections...) =>
            if collections? then refreshCollection(collection) for collection in collections
            else refreshAllCollections()

            return true

    @CollectionCache = new _CollectionCache(
        PoliticalQuestions:
            update: -> PoliticalQuestions.find({ currentlyActive: true }, { sort: { number: 1 } }).fetch()
            exclude: ["answerResemblanceToPartyMatrix", "currentlyActive", "createdAt", "updatedAt"]

        PersonalQuestions:
            update: -> PersonalQuestions.find({}, { sort: { order: 1 } }).fetch()
            exclude: ["createdAt", "updatedAt"]

        PoliticalParties:
            update: -> PoliticalParties.find().fetch()
            exclude: ["createdAt", "updatedAt"]

        Topics:
            update: -> Topics.find({}).fetch()
            exclude: ["createdAt", "updatedAt"]

        Translations:
            update: -> Translations.find({}).fetch()
            clientTransform: (value) ->
                result = {}

                for translation in value
                    translationArray = _.pluck(translation.translations.sort(( (a, b) -> if b.lang < a.lang then 1 else -1 )), 'value')

                    if _.uniq(translationArray).length is 1
                        translationArray = translationArray[0]

                    result[translation._id] = translationArray

                result

        ,
        _cc
    )





