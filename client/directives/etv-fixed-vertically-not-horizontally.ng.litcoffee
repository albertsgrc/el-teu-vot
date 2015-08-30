# Directive to support scrolling horizontally for fixed elements

    fixedVerticallyNotHorizontally = ->
        restrict: 'A'
        link: (scope, element, attrs) ->
            originalMargin = parseFloat($(element).css('margin-left'))

            scope.$on('scroll', ->
                if not attrs.etvFixedVerticallyButNotHorizontally or $(element).is(attrs.etvFixedVerticallyButNotHorizontally)
                    $(element).css("margin-left", "#{originalMargin - $(document).scrollLeft()}px")
            )


    app.directive('etvFixedVerticallyButNotHorizontally', fixedVerticallyNotHorizontally)