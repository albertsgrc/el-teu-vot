# Slider directive

    sliderDirective = ($timeout) ->
        replace: true,
        restrict: 'E',
        templateUrl: "client/views/components/etv-slider.html"

        link: (scope, element, attrs) ->
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

                $(element[0]).find(".etv-slider").slider({
                    max: 10
                    orientation: currentOrientation
                }).off('slidechange').slider("pips", {
                        rest: "label"
                })

            scope.$on('resize', ->
                setSlider()
            )

            $timeout(setSlider)

    app.directive('etvSlider', ['$timeout', sliderDirective])