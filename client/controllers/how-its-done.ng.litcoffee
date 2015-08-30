# Methodology page controller

    HowItsDoneCtrl = ($scope) ->
        $scope.BASIC_QUESTION_OPTIONS = PoliticalQuestions.BASIC_QUESTION_OPTIONS

        $scope.isNoAnswer = (answer) -> answer is PoliticalQuestions.NO_ANSWER

        $scope.basicAnswers = _.without(PoliticalQuestions.BASIC_QUESTION_OPTIONS, PoliticalQuestions.NO_ANSWER)

        $scope.tableNumbers = [1..5]

    app.controller('HowItsDoneCtrl', ['$scope', HowItsDoneCtrl])