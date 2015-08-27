# Personal questions angular controller

    PersonalQuestionsCtrl = ($scope, $state, resultsService, questionsService, $meteor) ->
        questionsService.getPersonalQuestions().then( (result) ->
            $scope.questions = result
        )

        $scope.isValid = (question) ->
            regex = new RegExp(question.validate)
            regex.test(question.answer)

        $scope.isSelected = (question, option) -> question.answer is option

        $scope.isAnswered = (question) -> question?

        $scope.answerQuestion = (question, answer) -> question.answer = answer

        $scope.shouldShowErrorMessage = (question) ->
            question.type is 'input' and question.blurred and not question.valid

        allQuestionsAnswered = ->
            return _.every($scope.questions, (question) -> not question.mandatory or (question.answer? and (question.type isnt 'input' or $scope.isValid(question))))

        $scope.goToResults = ->
            if allQuestionsAnswered()
                resultsService.sendPersonalResults($scope.questions).then(
                    (resultId) ->
                        $state.go('results', { id: resultId, justCreated: true })
                    ,
                    (err) ->
                        console.log err
                )

            else
                goToMandatoryQuestions = ( ->
                    SCROLL_ANIMATION_TIME = 400

                    getMandatoryQuestionsPos = ->
                        $(".personalMandatoryQuestionsContainer").offset().top - $("header").outerHeight(true)

                    showAlert = ->
                        setTimeout((-> $(".etv-alert").modal("show")), 100)

                    $('html, body').animate({ scrollTop: getMandatoryQuestionsPos() }, SCROLL_ANIMATION_TIME, showAlert)
                )()

            return true

        $scope.setBlurred = (question) -> question.blurred = true



    app.controller('PersonalQuestionsCtrl', ['$scope', '$state', 'resultsService', 'questionsService', '$meteor', PersonalQuestionsCtrl])