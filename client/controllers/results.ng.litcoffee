# Results page angular controller

    ResultsCtrl = ($scope, $translate, $window) ->
        $scope.openedGraph = null;
        graphContainer = null

        isMedia = (alias) -> $(".device-#{alias}").is(':visible')

        placeGraphImm = (graph) ->
            if isMedia('xs') or $("##{graph}Graph").is(".insertPoint")
                graphContainer.insertAfter("##{graph}Graph")
            else
                graphContainer.insertAfter($("##{graph}Graph").nextAll(".insertPoint")[0])

        placeGraph = ->
            if $scope.openedGraph isnt null
                placeGraphImm($scope.openedGraph)


        $(document).ready( ->
            graphContainer = $(".graphGlobalContainer")
            angular.element($window).on('resize', placeGraph)
            $scope.$on('$destroy', -> angular.element($window).off('resize', placeGraph))
        )

        $scope.openGraph = (graph) ->
            if $scope.openedGraph is graph
                $scope.openedGraph = null

            else
                placeGraphImm(graph)

                $scope.openedGraph = graph







    app.controller('ResultsCtrl', ['$scope', '$translate', '$window', ResultsCtrl])