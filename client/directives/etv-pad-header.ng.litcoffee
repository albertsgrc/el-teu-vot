# Main header padding directive

    padHeaderDirective = ($timeout) ->
        restrict: 'A'
        link: (scope, element) ->
            setMainPadding = ->
                fixedHeader = $("header.fixedHeader")

                if fixedHeader.length > 0
                    $("#main").css({ "padding-top": fixedHeader.outerHeight(true) + "px" })

                return true

            $timeout(setMainPadding)
            scope.$on('layoutChange', setMainPadding)

    app.directive('etvPadHeader', ['$timeout', padHeaderDirective])