# Center questions vertically directive

    centerQuestionsVerticallyDirective = ($timeout) ->
        restrict: 'A'

        link: (scope, element) ->
            politicalVisible = false

            computeMargins = ->
                INCLUDE_MARGIN = true


                windowHeight = $(window).height()
                windowWidth = $(window).width()
                mainTopPadding = $("header").outerHeight(true)

                firstQuestionHeight = $("#politicalQuestionsListContainer .globalPoliticalQuestionContainer:first-child .politicalQuestionContainer").outerHeight(INCLUDE_MARGIN)
                lastQuestionHeight = $("#politicalQuestionsListContainer .globalPoliticalQuestionContainer:last-child .politicalQuestionContainer").outerHeight(INCLUDE_MARGIN)
                navigationHeight = $("#questionNavigationWrapper").outerHeight(INCLUDE_MARGIN)
                dividerHeight = 2
                endButtonHeight = $("#endTestButtonContainer").height()

                questionsTopMargin = Math.max(30, (windowHeight - 2*mainTopPadding - (firstQuestionHeight + 2*dividerHeight))/2)
                questionsBottomMargin = Math.max(40, (windowHeight - 2*mainTopPadding - (lastQuestionHeight + 2*dividerHeight))/2 + mainTopPadding - endButtonHeight)

                navigationTopMargin = Math.max(60, (windowHeight - navigationHeight)/2)

                return { questions: { top: questionsTopMargin, bottom: questionsBottomMargin }, navigation: { top: navigationTopMargin } }


            setQuestionsMargins =  _.throttle( ->
                margins = computeMargins();

                $("#politicalQuestionsContainer").css({ "margin-top": margins.questions.top + "px", "margin-bottom": margins.questions.bottom })
                $("#questionNavigationContainer").css({ "margin-top": margins.navigation.top })

                unless politicalVisible
                    $timeout((->
                            $("#politicalQuestionsContainer").css({ visibility: "visible" })
                            politicalVisible = true
                    ))
            , 100)

            $timeout(setQuestionsMargins)
            scope.$on('resize', setQuestionsMargins)
            scope.$on('politicalQuestionsHeightChange', setQuestionsMargins)

            $timeout(->
                $("img#logo").on('load', setQuestionsMargins)
            )
            scope.$on('$destroy', -> $("img#logo").off('load', setQuestionsMargins))

    app.directive('etvCenterQuestionsVertically', ['$timeout', centerQuestionsVerticallyDirective])