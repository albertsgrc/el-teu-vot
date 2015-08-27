# Questions service

    questionsService = ($meteor, $q) ->
        politicalQuestions = null
        personalQuestions = null

        pendingPoliticalRequests = []
        pendingPersonalRequests = []

        resolvePendingRequests = (obj, hasErr, type) ->
            pendingRequests = if type is 'political' then pendingPoliticalRequests else pendingPersonalRequests

            if hasErr
                for pendingRequest in pendingRequests
                    pendingRequest.reject(obj)
            else
                for pendingRequest in pendingRequests
                    pendingRequest.resolve(obj)

            pendingRequests = []

        (@reset = ->
            $meteor.call('getPoliticalQuestions').then(
                (result) ->
                    politicalQuestions = result
                    resolvePendingRequests(politicalQuestions, false, 'political')
            ,
                (error) ->
                    console.error "Error retrieveing political questions\n#{@etvPrint(error)}"
                    resolvePendingRequests(error, true, 'political')
            )

            $meteor.call('getPersonalQuestions').then(
                (result) ->
                    personalQuestions = result
                    resolvePendingRequests(personalQuestions, false, 'personal')
            ,
                (error) ->
                    console.error "Error retrieveing personal questions\n#{@etvPrint(error)}"
                    resolvePendingRequests(error, true, 'personal')
            )
        )()


        @getPoliticalQuestions = ->
            q = $q.defer()

            if politicalQuestions?
                q.resolve(politicalQuestions)
            else
                pendingPoliticalRequests.push q

            return q.promise

        @getPersonalQuestions = ->
            q = $q.defer()

            if personalQuestions?
                q.resolve(personalQuestions)
            else
                pendingPersonalRequests.push q

            return q.promise

        @



    app.service('questionsService', ['$meteor', '$q', questionsService])