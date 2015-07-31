# Navigation directive

    sideNavDirective = ->
        replace: true,
        restrict: 'E',
        templateUrl: "client/views/components/etv-side-nav.html"

    app.directive('etvSideNav', sideNavDirective)