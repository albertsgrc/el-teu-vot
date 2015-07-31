# Side navigation controller

    NavCtrl = ($scope, $mdSidenav, $state) ->
        $scope.close = ->
            $mdSidenav('right').close()

        $scope.goTo = (state) ->
            $("md-backdrop").remove()
            $scope.close()
            $state.go(state)

    app.controller('NavCtrl', ['$scope', '$mdSidenav', '$state', NavCtrl])