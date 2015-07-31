# Footer directive

    footerDirective = ->
        replace: true,
        restrict: 'E',
        templateUrl: "client/views/components/etv-footer.html"

    app.directive('etvFooter', footerDirective)