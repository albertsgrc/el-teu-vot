# El teu Vot controller

    elTeuVotCtrl = ($scope, $meteor, $state, $stateParams, $timeout, $location) ->
        ga('send', 'pageview', '/')

        $scope.count = 0

        $scope.$meteorSubscribe("resultsCount")

        $scope.$meteorAutorun( ->
            $scope.count = Counts.get('results-count')
        )

        $scope.goToPoliticalQuestions = ->
            $timeout(-> $state.go('politicalQuestions'))

        $scope.goToExample = ->
            $meteor.call('getResult').then((id) ->
                console.log id
                $location.path("/resultats/#{id}")
            )

    app.controller('ElTeuVotCtrl', ['$scope', '$meteor', '$state', '$stateParams', '$timeout', '$location', elTeuVotCtrl])