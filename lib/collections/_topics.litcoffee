# Topics collection and schema

    @Topics = new Mongo.Collection('Topics')

    Topics.TOPIC_WEIGHT_BY_ORDER_INDEX = [0.25, 0.225, 0.2, 0.175, 0.15]
    Topics.TOPIC_WEIGHT_BY_ORDER_INDEX_STRING = ["0,25", "0,225", "0,2", "0,175", "0,15"]

    Schemas.Topic = new SimpleSchema(
        _id:
            type: String
            min: 1
            max: 50

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

    Topics.attachSchema(Schemas.Topic)

