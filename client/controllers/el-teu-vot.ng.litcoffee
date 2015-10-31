# El teu Vot controller

    elTeuVotCtrl = ($scope, $meteor, $state, $stateParams, $timeout) ->
        ga('send', 'pageview', '/')

        $scope.goToPoliticalQuestions = ->
            $timeout(-> $state.go('politicalQuestions'))

        $scope.viewGraphExample = ->
            $timeout(-> $state.go('results', { id: "pqHvEz6qEj4Ea5ix9" }))

    app.controller('ElTeuVotCtrl', ['$scope', '$meteor', '$state', '$stateParams', '$timeout', elTeuVotCtrl])