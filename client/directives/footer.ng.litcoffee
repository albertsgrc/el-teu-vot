# Footer directive

    footerDirective = ->
        replace: true,
        restrict: 'E',
        templateUrl: "client/views/templates/footer.html"

    app.directive('etvFooter', footerDirective)