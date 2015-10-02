# El teu Vot controller

    elTeuVotCtrl = ($scope, $meteor, $state, $stateParams, $timeout) ->
        ga('send', 'pageview', '/')

        $scope.goToPoliticalQuestions = ->
            $timeout(-> $state.go('politicalQuestions'))

    app.controller('ElTeuVotCtrl', ['$scope', '$meteor', '$state', '$stateParams', '$timeout', elTeuVotCtrl])