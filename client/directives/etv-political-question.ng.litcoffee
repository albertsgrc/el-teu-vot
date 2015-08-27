# Political question directive

    politicalQuestionDirective = ->
        replace: true,
        restrict: 'E',
        templateUrl: "client/views/components/etv-political-question.html"

    app.directive('etvPoliticalQuestion', politicalQuestionDirective)