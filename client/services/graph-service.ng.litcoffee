# Graph reordering service

    graphService = ->
        subscribers = {
            toggleGraph: []
        }

        openedGraphsMap = null
        openedGraphs = null

        (@reset = ->
            openedGraphs = []
            openedGraphsMap = {}
        )()


        callSubscribers = (subscription, callArguments...) ->
            subscriber(callArguments...) for subscriber in subscribers[subscription]

        @scrollToGraph = (graphName) ->
            graphOffset = $(".graphGlobalContainer.#{graphName}").offset().top - $("header.fixedHeader").outerHeight(true)

            $('html, body').animate({ scrollTop: graphOffset }, 200)

        @isGraphOpened = (graphName) -> openedGraphsMap[graphName]?

        @toggleGraph = (graphName, close = false) ->
            if openedGraphsMap[graphName]?
                delete openedGraphsMap[graphName]
                openedGraphs.splice(openedGraphs.indexOf(graphName), 1)
                callSubscribers('toggleGraph', openedGraphs, 'removed', graphName)
            else unless close
                openedGraphsMap[graphName] = true
                openedGraphs.unshift(graphName)
                callSubscribers('toggleGraph', openedGraphs, 'added', graphName)

        @getOpenedGraphs = -> openedGraphs

        @on = (subscription, callback) -> subscribers[subscription].push callback

        @


    app.service('graphService', graphService)