# Question navigation directive

    questionNavigationDirective = ->
        restrict: 'E'
        replace: true
        templateUrl: "client/views/components/etv-question-navigation.html"

        link: (scope, element, attrs) ->


    app.directive('etvQuestionNavigation', questionNavigationDirective)