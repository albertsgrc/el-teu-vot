# Political parties service

    politicalPartiesService = ($meteor, $q) ->
        politicalParties = [
            { _id: "JxS", color: "#36b6a9", ideologicalLocation: 4, nationalLocation: 10 }
            { _id: "CSQEP", color: "#d80a30", ideologicalLocation: 3, nationalLocation: 7 }
            { _id: "CUP", color: "#fee300", ideologicalLocation: 2.23, nationalLocation: 10 }
            { _id: "PPC", color: "#37a7de", ideologicalLocation: 6.61, nationalLocation: 4 }
            { _id: "PSC", color: "#bc2025", ideologicalLocation: 3.77, nationalLocation: 6 }
            { _id: "Cs", color: "#e64f24", ideologicalLocation: 5.13, nationalLocation: 5.5 }
            { _id: "UDC", color: "#2253a1", ideologicalLocation: 6.3, nationalLocation: 7.5 }
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