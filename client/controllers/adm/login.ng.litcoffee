# Administration login page controller

    AdmLoginCtrl = ($scope, $state) ->
        $state.go('adm') if Meteor.user()?
        
        $scope.password = ""
        $scope.error = false

        onComplete = (err) ->
            if err
                $scope.error = true
                $scope.errorBold = true
                setTimeout((-> $scope.$apply( -> $scope.errorBold = false)), 500)
            else
                $scope.error = false
                $state.go('adm')

        $scope.login = ->
            Meteor.loginWithPassword('admin', $scope.password, onComplete)



    app.controller('AdmLoginCtrl', ['$scope', '$state', AdmLoginCtrl])