# Who we are page controller

    whoWeAreCtrl = ($scope) ->
        ga('send', 'pageview', { 'page': '/qui-som' })

        $scope.ETP_URL = "http://www.elteuparlament.cat/"
        $scope.APPS4CITIZENS_URL = "http://apps4citizens.org/"


    app.controller('WhoWeAreCtrl', ['$scope', whoWeAreCtrl])