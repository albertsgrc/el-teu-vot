# Questions service

    questionsService = ($meteor, $q) ->
        politicalQuestions = null
        personalQuestions = null

        pendingPoliticalRequests = []
        pendingPersonalRequests = []

        getPoliticalQuestionsError = false
        getPersonalQuestionsError = false

        resolvePendingRequests = (obj, hasErr, type) ->
            pendingRequests = if type is 'political' then pendingPoliticalRequests else pendingPersonalRequests

            if hasErr
                for pendingRequest in pendingRequests
                    pendingRequest.reject(obj)
            else
                for pendingRequest in pendingRequests
                    pendingRequest.resolve(obj)

            pendingRequests = []


        getPoliticalQuestions = ->
            $meteor.call('getPoliticalQuestions').then(
                (result) ->
                    politicalQuestions = result
                    getPoliticalQuestionsError = false
                    resolvePendingRequests(politicalQuestions, false, 'political')
            ,
                (error) ->
                    resolvePendingRequests(error, true, 'political')
                    getPoliticalQuestionsError = true
            )

        getPersonalQuestions = ->
            $meteor.call('getPersonalQuestions').then(
                (result) ->
                    personalQuestions = result
                    getPersonalQuestionsError = false
                    resolvePendingRequests(personalQuestions, false, 'personal')
            ,
                (error) ->
                    getPersonalQuestionsError = true
                    resolvePendingRequests(error, true, 'personal')
            )

        (@reset = ->
            getPoliticalQuestions()
            getPersonalQuestions()
        )()


        @getPoliticalQuestions = ->
            q = $q.defer()

            if politicalQuestions?
                q.resolve(politicalQuestions)
            else
                pendingPoliticalRequests.push q
                getPoliticalQuestions() if getPoliticalQuestionsError

            return q.promise

        @getPersonalQuestions = ->
            q = $q.defer()

            if personalQuestions?
                q.resolve(personalQuestions)
            else
                pendingPersonalRequests.push q
                getPersonalQuestions() if getPersonalQuestionsError

            return q.promise

        @



    app.service('questionsService', ['$meteor', '$q', questionsService])