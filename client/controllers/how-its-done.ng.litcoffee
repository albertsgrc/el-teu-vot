# Methodology page controller

    HowItsDoneCtrl = ($scope) ->
        ga('send', 'pageview', '/com-ho-hem-fet')

        $scope.BASIC_QUESTION_OPTIONS = PoliticalQuestions.BASIC_QUESTION_OPTIONS

        $scope.isNoAnswer = (answer) -> answer is PoliticalQuestions.NO_ANSWER

        $scope.basicAnswers = _.without(PoliticalQuestions.BASIC_QUESTION_OPTIONS, PoliticalQuestions.NO_ANSWER)

        $scope.tableNumbers = [0, 0.2, 1, 4, 5]

    app.controller('HowItsDoneCtrl', ['$scope', HowItsDoneCtrl])