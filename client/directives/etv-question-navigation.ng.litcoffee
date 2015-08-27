# Question navigation directive

    questionNavigationDirective = (questionNavigationService) ->
        restrict: 'E'
        replace: true
        templateUrl: "client/views/components/etv-question-navigation.html"
        scope: false

        link: (scope, element, attrs) ->
            questionNavigationService.goToQuestion = scope.goToQuestion = (questionNumber, callback) ->
                globalQuestion = $("#politicalQuestionsListContainer .globalPoliticalQuestionContainer:nth-child(#{questionNumber})")
                firstGlobalQuestion = $("#politicalQuestionsListContainer .globalPoliticalQuestionContainer:nth-child(1)")
                question = globalQuestion.find(".politicalQuestionContainer")
                questionOffset = $(globalQuestion).offset().top
                headerHeight = $("header").outerHeight(true)
                windowHeight = $(window).height()
                dividerHeight = $(".divider").height()
                questionHeight = question.outerHeight(true) + 2*dividerHeight

                offset = Math.min(questionOffset - headerHeight - 20, questionOffset - (windowHeight - questionHeight)/2)

                $('html, body').animate({ scrollTop: offset}, 400, callback || undefined)

                return true

3257

    app.directive('etvQuestionNavigation', ['questionNavigationService', questionNavigationDirective])