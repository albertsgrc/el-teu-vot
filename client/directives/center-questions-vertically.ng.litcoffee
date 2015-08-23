# Center questions vertically directive

    CenterQuestionsVerticallyDirective = ($timeout, $window, $rootScope) ->
        restrict: 'A'
        link: (scope, element) ->
            $rootScope.setQuestionsMargins = setQuestionsMargins = ->
                computeMargins = ->
                    INCLUDE_MARGIN = true

                    windowHeight = $(window).height()
                    windowWidth = $(window).width()
                    mainTopPadding = $("header").outerHeight(true)

                    firstQuestionHeight = $("#politicalQuestionsListContainer .globalPoliticalQuestionContainer:first-child .politicalQuestionContainer").outerHeight(INCLUDE_MARGIN)
                    lastQuestionHeight = $("#politicalQuestionsListContainer .globalPoliticalQuestionContainer:last-child .politicalQuestionContainer").outerHeight(INCLUDE_MARGIN)
                    navigationHeight = $("#questionNavigationWrapper").outerHeight(INCLUDE_MARGIN)
                    dividerHeight = $(".divider").height()
                    endButtonHeight = $("#endTestButtonContainer").height()

                    questionsTopMargin = Math.max(30, (windowHeight - 2*mainTopPadding - (firstQuestionHeight + 2*dividerHeight))/2)
                    questionsBottomMargin = Math.max(40, (windowHeight - 2*mainTopPadding - (lastQuestionHeight + 2*dividerHeight))/2 + mainTopPadding - endButtonHeight)

                    navigationTopMargin = Math.max(60, (windowHeight - navigationHeight)/2)

                    return { questions: { top: questionsTopMargin, bottom: questionsBottomMargin }, navigation: { top: navigationTopMargin } }

                margins = computeMargins();

                $("#politicalQuestionsContainer").css({ "margin-top": margins.questions.top + "px", "margin-bottom": margins.questions.bottom })
                $("#questionNavigationContainer").css({ "margin-top": margins.navigation.top })

                $("#politicalQuestionsContainer").css({ visibility: "visible" })

            $timeout(setQuestionsMargins)
            angular.element($window).on('load', setQuestionsMargins)
            angular.element($window).on('resize', setQuestionsMargins)
            scope.$on('$destroy', -> angular.element($window).off('resize load', setQuestionsMargins))

    app.directive('centerQuestionsVertically', ['$timeout', '$window', '$rootScope', CenterQuestionsVerticallyDirective])