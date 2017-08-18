# Slider directive

    sliderDirective = ($timeout) ->
        replace: true,
        restrict: 'E',
        templateUrl: "client/views/components/etv-slider.html"

        link: (scope, element, attrs) ->
            falseZero = false

            sliderOrientation = ->
                if window.innerWidth <= ORIENTATION_THRESHOLD then "vertical" else "horizontal"

            ORIENTATION_THRESHOLD = 700
            currentOrientation = "none"

            setSlider = ->
                nextOrientation = sliderOrientation()

                return if nextOrientation is currentOrientation

                currentOrientation = nextOrientation

                scope.__sliderLeftText = if currentOrientation is "vertical" then attrs.rightText else attrs.leftText
                scope.__sliderRightText = if currentOrientation is "vertical" then attrs.leftText else attrs.rightText
                scope.$digest()

                accessObject = (object, string) ->
                    properties = string.split(".")
                    result = object[properties[0]]
                    properties.shift()
                    for property in properties
                        result = result[property]
                    result

                currentValue = accessObject(scope, attrs.ngModel)

                setDefault = ->
                    falseZero = true
                    return 0


                $(element[0]).find(".etv-slider").slider({
                    value: currentValue or setDefault()
                    max: 10
                    orientation: currentOrientation
                }).off('slidechange').on('slidechange', (event, ui) ->
                    return unless ui.value? and not isNaN(ui.value) and not falseZero

                    scope.setQuestionAnswer(scope.question, ui.value)
                    scope.$apply()
                )
                .slider("pips", {
                        rest: "label"
                })

                falseZero = false

            scope.$on('resize', ->
                setSlider()
            )

            scope.$on('destroy', ->
                $(element[0]).off('slidechange')
            )

            $timeout(setSlider)

    app.directive('etvSlider', ['$timeout', sliderDirective])