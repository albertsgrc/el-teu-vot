# Question navigation directive

    questionNavigationDirective = (questionNavigationService, $timeout, $window) ->
        restrict: 'E'
        replace: true
        templateUrl: "client/views/components/etv-question-navigation.html"

        link: (scope, element, attrs) ->

            SCROLL_ANIMATION_TIME = 400
            MIN_TOP_MARGIN = 20
            DEBOUNCE_TIME = SCROLL_ANIMATION_TIME + 200

            offset = ->
                $(element).css("margin-right", "-#{$('body').width() - $(document).scrollLeft() - $(window).width()}px")

            scope.$on('scroll', offset)
            scope.$on('resize', offset)
            $timeout(->
                $(element).css("visibility", "visible")
                offset()
            )

            questionNavigationService.goToQuestion = scope.goToQuestion = _.throttle( (questionNumber, callback) ->
                globalQuestion = $("#politicalQuestionsListContainer .globalPoliticalQuestionContainer:nth-child(#{questionNumber})")
                question = globalQuestion.find(".politicalQuestionContainer")
                questionOffset = $(globalQuestion).offset().top
                headerHeight = $("header").outerHeight(true)
                windowHeight = $window.innerHeight
                dividerHeight = $(".divider").height()
                questionHeight = question.outerHeight(true) + 2*dividerHeight

                offset = Math.min(questionOffset - headerHeight - MIN_TOP_MARGIN, questionOffset - (windowHeight - questionHeight)/2)

                $('html, body').animate({ scrollTop: offset + 1 }, SCROLL_ANIMATION_TIME, callback or undefined)

                return true
            , DEBOUNCE_TIME)

    app.directive('etvQuestionNavigation', ['questionNavigationService', '$timeout', '$window', questionNavigationDirective])