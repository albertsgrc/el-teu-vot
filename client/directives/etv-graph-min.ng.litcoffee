# Graph miniature directive

    graphMinDirective = ->
        replace: true,
        restrict: 'E',
        templateUrl: "client/views/components/etv-graph-min.html"

    app.directive('etvGraphMin', graphMinDirective)