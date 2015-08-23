# Main header padding directive

    padHeaderDirective = ($timeout, $window) ->
        restrict: 'A'
        link: (scope, element) ->
            setMainPadding = ->
                fixedHeader = $("header.fixedHeader")

                if fixedHeader.length > 0
                    $("#main").css({ "padding-top": fixedHeader.outerHeight(true) + "px" })

                return true

            $timeout(setMainPadding)
            angular.element($window).on('load', setMainPadding)
            angular.element($window).on('resize', setMainPadding)

            scope.$on('$destroy', -> angular.element($window).off('resize load', setMainPadding))

    app.directive('etvPadHeader', ['$timeout', '$window', padHeaderDirective])