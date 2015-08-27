# Topics service

    topicsService = ($meteor, $q) ->
        topics = null

        pendingRequests = []

        resolvePendingRequests = (obj, hasErr) ->
            if hasErr
                for pendingRequest in pendingRequests
                    pendingRequest.reject(obj)
            else
                for pendingRequest in pendingRequests
                    pendingRequest.resolve(obj)

            pendingRequests = []

        $meteor.call('getTopics').then(
            (result) ->
                topics = result
                resolvePendingRequests(topics, false)
        ,
            (error) ->
                console.error "Error retrieveing topics\n#{@etvPrint(error)}"
                resolvePendingRequests(error, true)
        )

        @getTopics = ->
            q = $q.defer()

            if topics?
                q.resolve(topics)
            else
                pendingRequests.push q

            return q.promise

        @

    app.service('topicsService', ['$meteor', '$q', topicsService])