# Centered text directive. Used to display centered texts.

    centeredTextDirective = ->
        replace: true
        restrict: 'E'
        templateUrl: "client/views/components/etv-centered-text.html"

        scope:
            text: "@"

    app.directive('etvCenteredText', [centeredTextDirective])