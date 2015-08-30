# Watch height change directive

    watchHeightChangeDirective = ($rootScope) ->
        restrict: 'EA'

        link: (scope, element, attrs) ->
            watchHeightChange = scope.$eval(attrs.etvWatchHeightChange)

            if not watchHeightChange.firstNeeded or scope.$first
                selector = watchHeightChange.selector or element
                eventName = watchHeightChange.event

                scope.$watch(
                    -> $(selector).outerHeight(true)
                    ,
                    (newValue, oldValue) ->
                        $rootScope.$broadcast(eventName) if newValue isnt oldValue

                )

    app.directive('etvWatchHeightChange', ['$rootScope', watchHeightChangeDirective])

