# Graph reordering service

    graphService = ->
        subscribers = {
            toggleGraph: []
        }

        openedGraphsMap = {}

        openedGraphs = []

        callSubscribers = (subscription, callArguments...) ->
            subscriber(callArguments...) for subscriber in subscribers[subscription]

        @toggleGraph = (graphName) ->
            if openedGraphsMap[graphName]?
                delete openedGraphsMap[graphName]
                openedGraphs.splice(openedGraphs.indexOf(graphName), 1)
                callSubscribers('toggleGraph', openedGraphs, 'removed', graphName)
            else
                openedGraphsMap[graphName] = true
                openedGraphs.unshift(graphName)
                callSubscribers('toggleGraph', openedGraphs, 'added', graphName)


        @getOpenedGraphs = -> openedGraphs

        @on = (subscription, callback) ->
            subscribers[subscription].push callback

        @


    app.service('graphService', graphService)