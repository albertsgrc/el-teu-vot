# El teu Vot controller

    elTeuVotCtrl = ($scope, $meteor, $state, $stateParams, $timeout) ->
        ga('send', 'pageview', '/')

        $scope.count = 0

        $scope.$meteorSubscribe("resultsCount")

        $scope.$meteorAutorun( ->
            $scope.count = Counts.get('results-count')
        )

        $scope.goToPoliticalQuestions = ->
            $("#elTeuVotContainer").addClass("loading")
            $timeout(-> $state.go('politicalQuestions'))


    app.controller('ElTeuVotCtrl', ['$scope', '$meteor', '$state', '$stateParams', '$timeout', elTeuVotCtrl])