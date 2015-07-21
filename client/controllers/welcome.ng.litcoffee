# Welcome page controller

    WelcomeCtrl = ($scope, $state) ->
        $scope.goTo = (state) -> $state.go(state)

    app.controller('WelcomeCtrl', ['$scope', '$state', WelcomeCtrl])