# Graph directive

    graphDirective = ->
        replace: true,
        restrict: 'E',
        templateUrl: "client/views/components/etv-graph.html"

    app.directive('etvGraph', graphDirective)