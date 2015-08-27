# Sortable directive

    sortableDirective = (resultsService) ->
        restrict: 'EA'
        link: (scope, element, attrs) ->
            scope.question.answeredOption = {}

            getAnswer = -> ($(elem).attr("etv-value") for elem in $(element).find('li'))


            element.sortable({
                tolerance: 'touch'
                cancel: ''
                update: (e, ui) ->
                    if scope.question.answer?
                        scope.question.answer = getAnswer()
            })

            element.disableSelection()

            scope.answerOption = (option) ->
                scope.question.answeredOption[option] = true
                if _.size(scope.question.answeredOption) is scope.topics.length
                    scope.question.answer = getAnswer()

    app.directive('etvSortable', ['resultsService', sortableDirective])