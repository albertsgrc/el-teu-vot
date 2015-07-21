# Header directive

    headerDirective = ->
        replace: true,
        restrict: 'E',
        templateUrl: "client/views/templates/header.html"

    app.directive('etvHeader', headerDirective)