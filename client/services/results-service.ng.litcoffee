# Results control and sending service

    resultsService = ($q, $meteor, questionsService) ->
        answerResults = {}

        computedResults = null

        pendingRequests = {
            id: null
            value: []
        }

        self = @

        (@reset = ->
            answerResults = {
                sessionId: Random.id()
                
                political:

                    basicAnswers: []

                    ideologicalLocation: null

                    nationalLocation: null

                    topicOrder: null

                personal:
                    answers: []
            }
        )()

        resolvePendingRequests = (obj, hasError) ->
            if hasError
                for pendingRequest in pendingRequests.value
                    pendingRequest.reject(obj)
            else
                for pendingRequest in pendingRequests.value
                    pendingRequest.resolve(obj)

            pendingRequests.id = null
            pendingRequests.value = []

        retrieveResultsFromServer = (id) ->
            $meteor.call('getResults', id).then(
                (serverResults) ->
                    computedResults =
                        id: id
                        value: serverResults

                    resolvePendingRequests(computedResults.value, false)
                ,
                (error) ->
                    resolvePendingRequests(error, true)
            )

        @sendPoliticalResults = (questions) ->
            answerResults.political.basicAnswers = []
            for question in questions
                switch question.type
                    when "basic"
                        answerResults.political.basicAnswers.push
                            questionId: question._id
                            number: question.number
                            answer: question.answer

                    when "ideologicalLocation"
                        answerResults.political.ideologicalLocation = question.answer
                    when "nationalLocation"
                        answerResults.political.nationalLocation = question.answer
                    when "topicSort"
                        answerResults.political.topicOrder = question.answer

        @sendPersonalResults = (questions) ->
            answerResults.personal.answers = []
            for question in questions
                answerResults.personal.answers.push
                    questionId: question._id
                    answer: question.answer

            q = $q.defer()

            self.sendResultsToServerAndGetNewResults(q)

            return q.promise

        @getResults = (id) ->
            q = $q.defer()

            if not id? and not computedResults?
                q.reject("An id is needed")
                return q.promise

            id ?= computedResults.id

            if not computedResults? or computedResults.id isnt id
                if pendingRequests.value.size > 0
                    if pendingRequests.id is id
                        pendingRequests.value.push q
                    else
                        q.reject("Another pending request with different id")
                else
                    pendingRequests.id = id
                    pendingRequests.value.push q
                    retrieveResultsFromServer(id)
            else
                q.resolve(computedResults.value)

            return q.promise

        ###
        @sendRandomResults = ->
            q = $q.defer()
            etvRandomResults(
                (results) ->
                    answerResults = results
                    self.sendResultsToServerAndGetNewResults().then(
                        (res) -> q.resolve(res)
                    )
            )
            return q.promise
        ###

        @sendResultsToServerAndGetNewResults = (q = $q.defer()) ->
            questionsService.reset()

            $meteor.call('sendResults', answerResults).then(
                (resultsId) ->
                    self.reset()
                    q.resolve(resultsId)
                    self.getResults(resultsId)
                ,
                (error) ->
                    q.reject(error)
            )

            return q.promise

        @setPersonalQuestionAnswer = (id, value) ->
            for questionClass, obj of personalQuestions
                return question.answer = value for question in obj when question._id is id

        @isPersonalQuestionAnswered = (id) ->
            for questionClass, obj of personalQuestions
                return question.answer? for question in obj when question._id is id

        @areAllPersonalQuestionsAnsweredAndValid = ->
            return false for question in personalQuestions.mandatory when not question.answer? or (question.valid? and not question.valid)
            return true

        @

    app.service('resultsService', ['$q', '$meteor', 'questionsService', resultsService])
