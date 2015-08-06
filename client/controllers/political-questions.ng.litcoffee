# Political questions angular controller

    PoliticalQuestionsCtrl = ($scope, $rootScope, $timeout) ->
        $rootScope.highlightCurrentQuestion = highlightCurrentQuestion = ->
            currentScrollPos = $(window).scrollTop()
            questionIndex = 0
            question = null

            $('.globalPoliticalQuestionContainer').each( (elem) ->
                top = $(@).find(".divider").offset().top - $("#main").css("padding-top").replace("px", "") - $("#politicalQuestionsContainer").css("margin-top").replace("px", "")
                questionChild = $(@).find(".politicalQuestionContainer")
                bottom = top + questionChild.outerHeight(true) + 2

                if currentScrollPos + 150 >= top and currentScrollPos + 150 <= bottom
                    questionIndex = Number($(@).attr('index'))
                    question = questionChild;
            )

            $(".politicalQuestionContainer, .divider").css({ opacity: "0.5" })
            question.css({ opacity: "1" })
            $(".divider").eq(questionIndex).css({ opacity: "1" })
            $(".divider").eq(questionIndex + 1).css({ opacity: "1" })

        $timeout(highlightCurrentQuestion)
        $(window).scroll(highlightCurrentQuestion)
        $(window).on('resize', highlightCurrentQuestion)


        $scope.$on('$destroy', ->
            $(window).off('resize')
            $(window).off('scroll')
        )

    app.controller('PoliticalQuestionsCtrl', ['$scope', '$rootScope', '$timeout', PoliticalQuestionsCtrl])