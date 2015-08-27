# Personal question directive

    personalQuestionDirective = ->
        replace: true,
        restrict: 'E',
        templateUrl: "client/views/components/etv-personal-question.html"

    app.directive('etvPersonalQuestion', personalQuestionDirective)