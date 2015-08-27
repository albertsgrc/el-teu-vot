# Alert directive

    alertDirective = ->
        replace: true
        restrict: 'E'
        templateUrl: "client/views/components/etv-alert.html"

        scope:
            text: "@"

    app.directive('etvAlert', alertDirective)