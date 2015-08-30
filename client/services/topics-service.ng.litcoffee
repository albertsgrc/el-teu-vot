# Topics service

    topicsService = ($meteor, $q) ->
        topics = null
        error = false

        pendingRequests = []

        resolvePendingRequests = (obj, hasErr) ->
            if hasErr
                for pendingRequest in pendingRequests
                    pendingRequest.reject(obj)
            else
                for pendingRequest in pendingRequests
                    pendingRequest.resolve(obj)

            pendingRequests = []

        (getTopics = ->
            $meteor.call('getTopics').then(
                (result) ->
                    topics = result
                    error = false
                    resolvePendingRequests(topics, false)
                ,
                (err) ->
                    resolvePendingRequests(error, true)
                    error = true
            )
        )()

        @getTopics = ->
            q = $q.defer()

            if topics?
                q.resolve(topics)
            else
                pendingRequests.push q
                getTopics() if error

            return q.promise

        @

    app.service('topicsService', ['$meteor', '$q', topicsService])