# Slider directive

    sliderDirective = ($timeout, $rootScope) ->
        replace: true,
        restrict: 'E',
        templateUrl: "client/views/components/etv-slider.html"
        scope: false

        link: (scope, element, attrs) ->
            scope._etvSliderLeftText = attrs.leftText;
            scope._etvSliderRightText = attrs.rightText;
            setSlider =  ->
                width = window.innerWidth

                ORIENTATION_THRESHOLD = 650


                $(".etv-slider").slider({
                    max: 10
                    orientation: (if width <= ORIENTATION_THRESHOLD then "vertical" else "horizontal")
                })
                .slider("pips", {
                        rest: "label"
                })
                .on('slidechange', (elem, ui) ->
                    scope[attrs.valueObjectHolder][attrs.valueProperty] = ui.value
                )

                scope[attrs.valueObjectHolder][attrs.valueProperty] = 0

                $rootScope.setQuestionsMargins()
                $rootScope.highlightCurrentQuestion()

            $(window).on("resize.doResize", setSlider)
            $timeout(setSlider)

            scope.$on('$destroy', -> $(window).off("resize.doResize") )

    app.directive('etvSlider', ['$timeout', '$rootScope', sliderDirective])