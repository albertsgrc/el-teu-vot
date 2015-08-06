# Center questions vertically directive

    CenterQuestionsVerticallyDirective = ($timeout, $window, $rootScope) ->
        restrict: 'A'
        link: (scope, element) ->
            $rootScope.setQuestionsMargins = setQuestionsMargins = ->
                computeMargins = ->
                    INCLUDE_MARGIN = true

                    windowHeight = $(window).height()
                    windowWidth = $(window).width()
                    mainTopPadding = Number($("#main").css("padding-top").replace("px", ""))
                    firstQuestionHeight = $("#politicalQuestionsListContainer .globalPoliticalQuestionContainer:first-child .politicalQuestionContainer").outerHeight(INCLUDE_MARGIN)
                    lastQuestionHeight = $("#politicalQuestionsListContainer .globalPoliticalQuestionContainer:last-child .politicalQuestionContainer").outerHeight(INCLUDE_MARGIN)
                    dividerHeight = $(".divider").height()
                    endButtonHeight = $("#endTestButtonContainer").height()

                    topMargin = Math.max(40, (windowHeight - 2*mainTopPadding - (firstQuestionHeight + 2*dividerHeight))/2)
                    bottomMargin = Math.max(40, (windowHeight - 2*mainTopPadding - (lastQuestionHeight + 2*dividerHeight))/2 + mainTopPadding - endButtonHeight)

                    return { top: topMargin, bottom: bottomMargin }

                margins = computeMargins();

                $("#politicalQuestionsContainer").css({ "margin-top": margins.top + "px", "margin-bottom": margins.bottom })



            $timeout(setQuestionsMargins)
            angular.element($window).on('resize', setQuestionsMargins)
            scope.$on('$destroy', -> angular.element($window).off('resize'))

    app.directive('centerQuestionsVertically', ['$timeout', '$window', '$rootScope', CenterQuestionsVerticallyDirective])