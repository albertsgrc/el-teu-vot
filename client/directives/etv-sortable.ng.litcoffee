# Sortable directive

    sortableDirective = ->
        restrict: 'EA'
        replace: true
        templateUrl: "client/views/components/etv-sortable.html"

        link: (scope, element, attrs) ->
            answeredOptions = {}

            getAnswer = -> ($(elem).attr("etv-value") for elem in $(element).find('li[etv-value]'))

            element.find("ul").sortable({
                tolerance: 'touch'
                cancel: ''
                update: (e, ui) ->
                    if scope.question.answer?
                        scope.question.answer = getAnswer()

            })

            scope.answerOption = (option) ->
                answeredOptions[option] = true
                if _.size(answeredOptions) is scope.topics.length
                    scope.setQuestionAnswer(scope.question, getAnswer())

            scope.isAnswered = (option) ->
                answeredOptions[option] or (scope.question.answer? and scope.question.answer.indexOf(option) isnt -1)

    app.directive('etvSortable', [sortableDirective])