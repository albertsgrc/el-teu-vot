# Main header padding directive

    padHeaderDirective = ($timeout) ->
        restrict: 'A'
        link: (scope, element) ->

            setMainPadding = _.throttle( ->
                fixedHeader = $("header.fixedHeader")

                if fixedHeader.length > 0
                    $("#main").css({ "padding-top": fixedHeader.outerHeight(true) + "px" })

                return true
            , 50)

            scope.$on('resize', setMainPadding)

            $timeout(->
                $("img#logo").on('load', setMainPadding)
            )


            $timeout(setMainPadding)

            scope.$on('$destroy', -> $("img#logo").off('load', setMainPadding))

    app.directive('etvPadHeader', ['$timeout', padHeaderDirective])