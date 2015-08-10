# Angular route configuration

    Router = ($stateProvider, $urlRouterProvider, $locationProvider) ->
        # TODO: Make main state and put header and footer inside it
        $stateProvider
            .state('layout',
                abstract: true
                templateUrl: 'client/views/partials/layout.html'
                controller: 'LayoutCtrl'
            )
            .state('elTeuVot',
                parent: 'layout'
                url: '/'
                templateUrl: 'client/views/partials/el-teu-vot.html'
                controller: 'ElTeuVotCtrl'
            )
            .state('howItsDone',
                parent: 'layout'
                url: '/com-ho-hem-fet'
                templateUrl: 'client/views/partials/how-its-done.html'
                controller: 'HowItsDoneCtrl'
            )
            .state('whoWeAre',
                parent: 'layout'
                url: '/qui-som'
                templateUrl: 'client/views/partials/who-we-are.html'
                controller: 'WhoWeAreCtrl'
            )

        $urlRouterProvider.otherwise('/');

        $locationProvider.html5Mode(
            enabled: true
        )

    app.config(['$stateProvider', '$urlRouterProvider', '$locationProvider', Router])