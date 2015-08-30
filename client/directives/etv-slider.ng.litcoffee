# Slider directive

    sliderDirective = ($timeout) ->
        replace: true,
        restrict: 'E',
        templateUrl: "client/views/components/etv-slider.html"

        link: (scope, element, attrs) ->
            sliderSet = false
            shouldNotChangeSliderValue = false

            setSlider = _.debounce( ->
                width = window.innerWidth

                ORIENTATION_THRESHOLD = 650

                if sliderSet is "horizontal"
                    return if width > ORIENTATION_THRESHOLD
                else if sliderSet is "vertical"
                    return if width <= ORIENTATION_THRESHOLD

                sliderSet = (if width <= ORIENTATION_THRESHOLD then "vertical" else "horizontal")

                scope.$apply( ->
                    scope.__sliderLeftText = if sliderSet is "vertical" then attrs.rightText else attrs.leftText
                    scope.__sliderRightText = if sliderSet is "vertical" then attrs.leftText else attrs.rightText
                )

                accessObject = (object, string) ->
                    properties = string.split(".")
                    result = object[properties[0]]
                    properties.shift()
                    for property in properties
                        result = result[property]
                    result

                $(element[0]).find(".etv-slider").slider({
                    value: accessObject(scope, attrs.ngModel) or 0
                    max: 10
                    orientation: sliderSet
                }).off('slidechange').on('slidechange', (event, ui) ->
                    return unless ui.value? and not isNaN(ui.value) and not shouldNotChangeSliderValue

                    scope.$apply( ->
                        scope.setQuestionAnswer(scope.question, ui.value)
                    )
                )
                .slider("pips", {
                        rest: "label"
                })
            , 100)

            scope.$on('resize', ->
                shouldNotChangeSliderValue = true
                setSlider()
                shouldNotChangeSliderValue = false
            )
            $timeout(setSlider)

    app.directive('etvSlider', ['$timeout', sliderDirective])