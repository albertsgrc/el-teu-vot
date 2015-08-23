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
                    return if scope[attrs.valueObjectHolder].answer isnt null and ui.answer is null
                    $(".etv-slider .ui-slider-handle").addClass("touched") unless scope[attrs.valueObjectHolder].answer != null
                    scope.setAnswer('political', scope[attrs.valueObjectHolder], ui.value)
                    scope.$apply()
                )

                $rootScope.setQuestionsMargins()
                $rootScope.highlightCurrentQuestion()

            $(window).on("resize.doResize", setSlider)
            $timeout(setSlider)

            scope.$on('$destroy', -> $(window).off("resize.doResize", setSlider) )

    app.directive('etvSlider', ['$timeout', '$rootScope', sliderDirective])