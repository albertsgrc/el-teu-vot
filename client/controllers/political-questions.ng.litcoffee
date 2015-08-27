# Political questions angular controller

    PoliticalQuestionsCtrl = ($scope, $state, resultsService, questionsService, topicsService, questionNavigationService, $meteor) ->
        questionsService.getPoliticalQuestions().then( (data) ->
            $scope.questions = data
        )

        topicsService.getTopics().then( (data) ->
            $scope.topics = data
        )

        $scope.BASIC_QUESTION_OPTIONS = PoliticalQuestions.BASIC_QUESTION_OPTIONS

        $scope.isAnswered = (number) ->
            _.find($scope.questions, (question) -> question.number is number).answer?

        $scope.goToPersonalQuestions = ->
            firstUnAnsweredQuestion = ( ->
                return parseInt(i) + 1 for i, x of $scope.questions when not x.answer?
                return null
            )()

            unless firstUnAnsweredQuestion?
                resultsService.sendPoliticalResults($scope.questions)
                $state.go('personalQuestions')
            else
                goToFirstUnAnsweredQuestion = ( ->
                    showAlert = ->
                        setTimeout((-> $(".etv-alert").modal("show")), 100)

                    questionNavigationService.goToQuestion(firstUnAnsweredQuestion, showAlert)

                )()

            return true

    app.controller('PoliticalQuestionsCtrl', ['$scope', '$state', 'resultsService', 'questionsService', 'topicsService', 'questionNavigationService', '$meteor', PoliticalQuestionsCtrl])