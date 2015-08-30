# Directive to offset centered elements based on some other element's position

    offsetOnElement = ($timeout) ->
        restrict: 'EA'

        link: (scope, element, attrs) ->
            isOffseted = false
            MARGIN = 15
            offset = _.throttle( ->
                elemTop = $(element).offset().top - parseFloat($(element).css("margin-top"))
                targetBottom = $(attrs.etvOffsetOnElement).outerHeight(true)
                if elemTop <= targetBottom + MARGIN
                    isOffseted = true
                    $(element).css("margin-top", "#{targetBottom + MARGIN - elemTop}px")
                else if isOffseted
                    isOffseted = false
                    $(element).css("margin-top", "0px")
            , 25)


            scope.$on('resize', offset)
            scope.$on('load', offset)
            $timeout(offset)

    app.directive('etvOffsetOnElement', ['$timeout', offsetOnElement])