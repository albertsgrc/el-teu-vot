# Topics service

    topicsService = ($meteor, $q) ->
        topics = [
            { _id: "regeneracioDemocratica" }
            { _id: "modelTerritorial" }
            { _id: "estatDelBenestar" }
            { _id: "ciutadania" }
            { _id: "territoriEcologiaIMediAmbient" }
        ]
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

        @getTopics = ->
            q = $q.defer()

            if topics?
                q.resolve(topics)
            else
                pendingRequests.push q

            return q.promise

        @

    app.service('topicsService', ['$meteor', '$q', topicsService])