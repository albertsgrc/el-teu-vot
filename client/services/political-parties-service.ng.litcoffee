# Political parties service

    politicalPartiesService = ($meteor, $q) ->
        politicalParties = null

        pendingRequests = []

        resolvePendingRequests = (obj, hasErr) ->
            if hasErr
                for pendingRequest in pendingRequests
                    pendingRequest.reject(obj)
            else
                for pendingRequest in pendingRequests
                    pendingRequest.resolve(obj)

            pendingRequests = []

        $meteor.call('getPoliticalParties').then(
            (result) ->
                politicalParties = result
                resolvePendingRequests(politicalParties, false)
            ,
            (error) ->
                console.error "Error retrieveing political parties\n#{@etvPrint(error)}"
                resolvePendingRequests(error, true)
        )

        @getPoliticalParties = ->
            q = $q.defer()

            if politicalParties?
                q.resolve(politicalParties)
            else
                pendingRequests.push q

            return q.promise

        @


    app.service('politicalPartiesService', ['$meteor', '$q', politicalPartiesService])