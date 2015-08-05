# Center questions vertically directive

    CenterQuestionsVerticallyDirective = ($timeout, $window) ->
        restrict: 'A'
        link: (scope, element) ->
            setQuestionsMargins = ->
                computeMargins = ->
                    INCLUDE_MARGIN = true

                    windowHeight = $(window).height()
                    mainTopPadding = $("#main").css("padding-top").replace("px", "")
                    questionHeight = $(".politicalQuestionContainer").outerHeight(INCLUDE_MARGIN)
                    dividerHeight = $(".divider").height()
                    endButtonHeight = $("#endButton").outerHeight(INCLUDE_MARGIN)

                    topMargin = Math.max(20, (windowHeight - 2*mainTopPadding - (questionHeight + 2*dividerHeight))/2)
                    bottomMargin = Math.max(40, topMargin - endButtonHeight)

                    return { top: topMargin, bottom: bottomMargin }

                margins = computeMargins();

                $("#politicalQuestionsContainer").css({ "margin-top": margins.top + "px", "margin-bottom": margins.bottom })



            $timeout(setQuestionsMargins)
            angular.element($window).on('resize', setQuestionsMargins)
            scope.$on('$destroy', -> angular.element($window).off('resize'))

    app.directive('centerQuestionsVertically', ['$timeout', '$window', CenterQuestionsVerticallyDirective])