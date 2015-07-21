# Side navigation controller

    NavCtrl = ($scope, $mdSidenav) ->
        $scope.close = -> $mdSidenav('right').close()

    app.controller('NavCtrl', ['$scope', '$mdSidenav', NavCtrl])