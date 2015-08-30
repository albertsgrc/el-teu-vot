# Political parties service

    politicalPartiesService = ($meteor, $q) ->
        politicalParties = null

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

        (getPoliticalParties = ->
            $meteor.call('getPoliticalParties').then(
                (result) ->
                    politicalParties = result
                    resolvePendingRequests(politicalParties, false)
                    error = false
                ,
                (err) ->
                    resolvePendingRequests(error, true)
                    error = true
            )
        )()

        @getPoliticalParties = ->
            q = $q.defer()

            if politicalParties?
                q.resolve(politicalParties)
            else
                pendingRequests.push q
                getPoliticalParties() if error

            return q.promise

        @


    app.service('politicalPartiesService', ['$meteor', '$q', politicalPartiesService])