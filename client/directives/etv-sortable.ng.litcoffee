# Sortable directive

    sortableDirective = ->
        restrict: 'EA'
        replace: true
        templateUrl: "client/views/components/etv-sortable.html"

        link: (scope, element, attrs) ->
            answeredOptions = {}

            getAnswer = -> ($(elem).attr("etv-value") for elem in $(element).find('li'))

            element.find("ul").sortable({
                tolerance: 'touch'
                cancel: ''
                update: (e, ui) ->
                    if scope.question.answer?
                        scope.question.answer = getAnswer()
            })

            element.disableSelection()

            scope.answerOption = (option) ->
                answeredOptions[option] = true
                if _.size(answeredOptions) is scope.topics.length
                    scope.setQuestionAnswer(scope.question, getAnswer())

            scope.isAnswered = (option) -> answeredOptions[option]

    app.directive('etvSortable', [sortableDirective])