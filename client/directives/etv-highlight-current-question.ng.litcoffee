# Highlight current question directive

    highlightCurrentQuestionDirective = ($timeout) ->
        restrict: 'A'

        link: (scope, element, attrs) ->
            highlightCurrentQuestion = _.throttle( ->
                currentScrollPos = $(window).scrollTop()
                questionIndex = 0
                question = null

                HIGHLIGHT_OFFSET = 185
                DIVIDER_HEIGHT = 2

                $('.globalPoliticalQuestionContainer').each( (elem) ->
                    top = $(@).find(".divider").offset().top - parseFloat($("#main").css("padding-top")) - parseFloat($("#politicalQuestionsContainer").css("margin-top"))
                    questionChild = $(@).find(".politicalQuestionContainer")
                    bottom = top + questionChild.outerHeight(true) + DIVIDER_HEIGHT
                    offsetedCurrentPos = currentScrollPos + HIGHLIGHT_OFFSET

                    if offsetedCurrentPos >= top and offsetedCurrentPos <= bottom
                        questionIndex = Number($(@).attr('index'))
                        question = questionChild
                        return false
                )

                return unless question

                $(".politicalQuestionContainer, .divider").css({ opacity: "0.5" })
                question.css({ opacity: "1" })
                $(".divider").eq(questionIndex).css({ opacity: "1" })
                $(".divider").eq(questionIndex + 1).css({ opacity: "1" })
            , 250)

            $timeout(highlightCurrentQuestion)
            scope.$on('politicalQuestionHeightChange', highlightCurrentQuestion)
            scope.$on('resize', highlightCurrentQuestion)
            scope.$on('scroll', highlightCurrentQuestion)

    app.directive('etvHighlightCurrentQuestion', ['$timeout', highlightCurrentQuestionDirective])