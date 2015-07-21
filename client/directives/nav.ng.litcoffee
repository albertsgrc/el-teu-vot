# Navigation directive

    navDirective = ->
        replace: true,
        restrict: 'E',
        templateUrl: "client/views/templates/nav.html"

    app.directive('etvNav', navDirective)