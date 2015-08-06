# Slider directive

    sliderDirective = ($timeout, $rootScope) ->
        replace: true,
        restrict: 'E',
        templateUrl: "client/views/components/etv-slider.html"
        scope: {
            leftText: '='
            rightText: '='
        }

        link: (scope, element, attrs) ->
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

                $rootScope.setQuestionsMargins()
                $rootScope.highlightCurrentQuestion()

            $(window).on("resize.doResize", setSlider)
            $timeout(setSlider)

            scope.$on('$destroy', -> $(window).off("resize.doResize") )

    app.directive('etvSlider', ['$timeout', '$rootScope', sliderDirective])