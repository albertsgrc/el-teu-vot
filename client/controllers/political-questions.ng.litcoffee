# Political questions angular controller

    PoliticalQuestionsCtrl = ($scope) ->
        highlightCurrentQuestion = ->
            questionHeight = $(".politicalQuestionContainer:first").outerHeight(true)
            topMargin = $("#politicalQuestionsListContainer").css("margin-top").replace("px", "")
            questionIndex  = Math.max(0, ($(window).scrollTop() + questionHeight/2)//questionHeight)
            question = $(".politicalQuestionContainer").eq(questionIndex)

            $(".politicalQuestionContainer, .divider").css({ opacity: "0.5" })
            question.css({ opacity: "1" })
            $(".divider").eq(questionIndex).css({ opacity: "1" })
            $(".divider").eq(questionIndex + 1).css({ opacity: "1" })

        $(window).scroll(highlightCurrentQuestion)
        $(window).on('resize', highlightCurrentQuestion)

        $scope.$on('$destroy', ->
            $(window).off('resize')
            $(window).off('scroll')
        )

    app.controller('PoliticalQuestionsCtrl', ['$scope', PoliticalQuestionsCtrl])