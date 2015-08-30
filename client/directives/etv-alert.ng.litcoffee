# Alert directive

    alertDirective = (etvAlertService) ->
        replace: true
        restrict: 'E'
        templateUrl: "client/views/components/etv-alert.html"

        scope:
            text: "@"

        link: (scope, element, attrs) ->
            scope.close = etvAlertService.closeAlert

    app.directive('etvAlert', ['etvAlertService', alertDirective])