# Meteor publications

    Meteor.publish('resultsCount', ->
        Counts.publish(@, 'results-count', Results.find())
        return undefined
    )