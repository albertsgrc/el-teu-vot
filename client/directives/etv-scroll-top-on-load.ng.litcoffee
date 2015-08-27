# Scroll to top on load directive

    scrollToTopOnLoadDirective = ($timeout) ->
        restrict: 'A'

        link: (scope, element, attrs) ->
            $timeout(-> $("body").scrollTop(0))


    app.directive('etvScrollToTopOnLoad', ['$timeout', scrollToTopOnLoadDirective])