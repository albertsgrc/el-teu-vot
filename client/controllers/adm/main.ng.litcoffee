# Global Administration controller

    AdmMainCtrl = ($rootScope) ->
        $rootScope.isAdm = true

    app.controller('AdmMainCtrl', ['$rootScope', AdmMainCtrl])