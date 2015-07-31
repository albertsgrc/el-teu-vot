# Questions angular controller

    QuestionsCtrl = ($scope) ->
        $scope.points = (point for point in [1..30])

    app.controller('QuestionsCtrl', ['$scope', QuestionsCtrl])