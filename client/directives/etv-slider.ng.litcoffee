# Slider directive

    sliderDirective = ($timeout, $rootScope) ->
        replace: true,
        restrict: 'E',
        templateUrl: "client/views/components/etv-slider.html"
        scope: false

        compile: (element, attrs) ->
            angular.element(element[0]).find(".leftText").attr("translate", "{{ '#{attrs.leftText}' }}")
            angular.element(element[0]).find(".rightText").attr("translate", "{{ '#{attrs.rightText}' }}")
            angular.element(element[0]).find(".etv-slider").attr("ng-class", "{ 'touched': isAnswered(question.number) }")

            pre: (scope, element, attrs) ->

            post: (scope, element, attrs) ->
                sliderSet = false
                shouldNotChangeSliderValue = false

                setSlider = ->
                    width = window.innerWidth

                    ORIENTATION_THRESHOLD = 650

                    if sliderSet is "horizontal"
                        return if width > ORIENTATION_THRESHOLD
                    else if sliderSet is "vertical"
                        return if width <= ORIENTATION_THRESHOLD

                    sliderSet = (if width <= ORIENTATION_THRESHOLD then "vertical" else "horizontal")

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
                            scope.question.answer = ui.value
                        )
                    )
                    .slider("pips", {
                            rest: "label"
                    })

                    $rootScope.$broadcast('layoutChange', 'slider')

                scope.$on('layoutChange', (event, name) ->
                    shouldNotChangeSliderValue = true
                    if name isnt 'slider' then setSlider()
                    shouldNotChangeSliderValue = false
                )
                $timeout(setSlider)

    app.directive('etvSlider', ['$timeout', '$rootScope', sliderDirective])