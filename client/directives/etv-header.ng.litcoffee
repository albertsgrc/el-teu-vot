# Header directive

    headerDirective = ->
        replace: true,
        restrict: 'E',
        templateUrl: "client/views/components/etv-header.html"

    app.directive('etvHeader', headerDirective)