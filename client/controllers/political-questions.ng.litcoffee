# Political questions angular controller

    PoliticalQuestionsCtrl = ($scope, $state, resultsService, questionsService, topicsService, questionNavigationService, $meteor, etvAlertService, $translate, $timeout) ->
        $scope.loadingCounter = 2
        $scope.error = false


        ga('send', 'pageview', { 'page': '/questionari', 'title': 'Qüestionari polític' })

        notifyError = ->
            console.error "Error loading some data from the server"
            $scope.error = true

        onDataLoad = ->
            --$scope.loadingCounter

        questionsService.getPoliticalQuestions().then(
            (data) ->
                $scope.questions = data
                onDataLoad()
            ,
            notifyError
        )

        topicsService.getTopics().then(
            (data) ->
                $scope.topics = data
                onDataLoad()
            ,
            notifyError
        )


        $scope.watchHeightChangeOn =
            firstNeeded: true
            selector: '#politicalQuestionsListContainer .globalPoliticalQuestionContainer:first-child .politicalQuestionContainer'
            event: 'politicalQuestionsHeightChange'

        $scope.questionTopic = (question) -> question.topic or 'spaces'

        $scope.questionText = (question) -> 'question' + question.number

        $scope.isNoAnswer = (answer) -> answer is PoliticalQuestions.NO_ANSWER

        $scope.isAnsweredWith = (question, option) -> question.answer is option

        $scope.isLongAnswer = (answer) -> answer is 'nand' and $translate.use() is 'es'

        $scope.shouldShowLoading = -> $scope.loadingCounter and not $scope.error

        $scope.shouldShowQuestions = -> not $scope.loadingCounter

        $scope.shouldShowError = -> $scope.error

        $scope.setQuestionAnswer = (question, answer) -> question.answer = answer

        $scope.BASIC_QUESTION_OPTIONS = PoliticalQuestions.BASIC_QUESTION_OPTIONS

        $scope.isAnswered = (number) ->
            _.find($scope.questions, (question) -> question.number is number).answer?

        $scope.goToPersonalQuestions = ->
            ###
            if "localhost" is window.location.hostname
                resultsService.sendRandomResults().then(
                    (res) -> $state.go('results', { id: res })
                )
                return
            ###
            firstUnAnsweredQuestion = ( ->
                return parseInt(i) + 1 for i, x of $scope.questions when not x.answer?
                return null
            )()

            unless firstUnAnsweredQuestion?
                resultsService.sendPoliticalResults($scope.questions)
                $state.go('personalQuestions', { cameFromVerification: 'sedawidaiov' })
            else
                ga('send', 'event', 'user-error', 'political-questions-not-answered')
                goToFirstUnAnsweredQuestion = ( ->
                    showAlert = ->
                        $timeout((-> etvAlertService.openAlert('politicalQuestionsAlert')), 100)
                    questionNavigationService.goToQuestion(firstUnAnsweredQuestion, showAlert)

                )()

            return true

    app.controller('PoliticalQuestionsCtrl', ['$scope', '$state', 'resultsService', 'questionsService', 'topicsService', 'questionNavigationService', '$meteor', 'etvAlertService', '$translate', '$timeout', PoliticalQuestionsCtrl])