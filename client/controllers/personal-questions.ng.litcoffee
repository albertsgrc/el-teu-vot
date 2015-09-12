# Personal questions angular controller

    PersonalQuestionsCtrl = ($scope, $state, resultsService, questionsService, $meteor, etvAlertService, $timeout, $stateParams) ->
        $state.go('politicalQuestions') unless $stateParams.cameFromVerification is 'sedawidaiov'

        ga('send', 'pageview', { 'page': '/questionari', 'title': 'Qüestionari personal' })

        MAX_SEND_RESULTS_SECONDS_DELAY = 20

        sendResultsStarted = false

        errorSending = false

        nFailures = 0

        MAX_FAILURES = 5

        $scope.loadingCounter = 1
        $scope.error = false

        questionsService.getPersonalQuestions().then(
            (result) ->
                $scope.questions = result
                --$scope.loadingCounter
                $scope.error = false
            ,
            (err) ->
                $scope.error = true
        )

        $scope.endQuestionaireText = "endQuestionaireText"

        $scope.isValid = (question) ->
            regex = new RegExp(question.validate)
            regex.test(question.answer)

        $scope.isSelected = (question, option) -> question.answer is option

        $scope.questionTitle = (question) -> question._id

        $scope.isFocusable = (question) -> question.type is 'input'

        $scope.isAnswered = (question) -> question?

        $scope.onInputTextChange = (question) -> question.valid = $scope.isAnswered(question) and $scope.isValid(question)

        $scope.answerQuestion = (question, answer) -> question.answer = answer

        $scope.shouldShowPersonalQuestionsError = -> $scope.error

        $scope.shouldShowPersonalQuestions = -> not $scope.loadingCounter

        $scope.shouldShowLoading = -> $scope.loadingCounter and not $scope.error

        $scope.shouldShowErrorMessage = (question) ->
            question.type is 'input' and question.blurred and not question.valid

        allQuestionsAnswered = ->
            return _.every($scope.questions, (question) -> not question.mandatory or (question.answer? and (question.type isnt 'input' or $scope.isValid(question))))

        onSendResultsSuccess = (id) ->
            ga('send','event','navigation','send-results-success')

            $state.go('results', { id: id, justCreated: true })
            errorSending = false

        onSendResultsFailure = ->
            console.error "Send results failure nº #{nFailures}"

            $scope.endQuestionaireText = "endQuestionaireText"
            sendResultsStarted = false
            errorSending = true
            ++nFailures
            if nFailures is MAX_FAILURES + 1
                etvAlertService.openAlert("sendResultsErrorNoMoreClick")
            else
                etvAlertService.openAlert("sendResultsError")

        $scope.goToResults = ->
            if allQuestionsAnswered() and not sendResultsStarted
                if nFailures <= MAX_FAILURES
                    $scope.endQuestionaireText = "sendingResults"
                    sendResultsStarted = true

                    $timeout( ->
                        if $state.includes('personalQuestions') and not errorSending
                            ga('send', 'event', 'delay', 'send-results-too-long-delay')
                            $scope.endQuestionaireText = "endQuestionaireText"
                            sendResultsStarted = false
                            etvAlertService.openAlert('sendResultsTooLongDelay')
                    , 1000*MAX_SEND_RESULTS_SECONDS_DELAY)

                    if errorSending
                        resultsService.sendResultsToServerAndGetNewResults().then(
                            onSendResultsSuccess
                            ,
                            onSendResultsFailure
                        )
                    else
                        resultsService.sendPersonalResults($scope.questions).then(
                            onSendResultsSuccess
                            ,
                            onSendResultsFailure
                        )
                else
                    questionsService.reset()
                    resultsService.reset()
                    $state.go('politicalQuestions')

            else
                goToMandatoryQuestions = ( ->
                    ga('send','event','user-error', 'personal-questions-not-answered')
                    SCROLL_ANIMATION_TIME = 400

                    getMandatoryQuestionsPos = ->
                        $(".personalMandatoryQuestionsContainer").offset().top - $("header").outerHeight(true)

                    showAlert = ->
                        $timeout((-> etvAlertService.openAlert('personalQuestionsAlert')), 100)

                    $('html, body').animate({ scrollTop: getMandatoryQuestionsPos() }, SCROLL_ANIMATION_TIME, showAlert)
                )()

            return true

        $scope.setBlurred = (question) -> question.blurred = true



    app.controller('PersonalQuestionsCtrl', ['$scope', '$state', 'resultsService', 'questionsService', '$meteor', 'etvAlertService', '$timeout', '$stateParams', PersonalQuestionsCtrl])