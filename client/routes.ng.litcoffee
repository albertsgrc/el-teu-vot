# Angular route configuration

    Router = ($stateProvider, $urlRouterProvider, $locationProvider) ->
        # TODO: Make main state and put header and footer inside it
        $stateProvider
            .state('layout',
                abstract: true,
                templateUrl: 'client/views/partials/layout.html',
                controller: 'LayoutCtrl'
            )
            .state('elTeuVot',
                parent: 'layout',
                url: '/',
                templateUrl: 'client/views/partials/el-teu-vot.html',
                controller: 'ElTeuVotCtrl'
            )
            .state('questions',
                parent: 'layout',
                abstract: true
                url: '/preguntes',
                controller: 'QuestionsCtrl'
            )
            .state('politicalQuestions',
                parent: 'questions',
                url: '/politica'
            )
            .state('personalQuestions',
                parent: 'questions',
                url: '/personals'
            )
            .state('howItsDone',
                parent: 'layout',
                url: '/com-ho-fem',
                templateUrl: 'client/views/partials/how-its-done.html'
                controller: 'HowItsDoneCtrl'
            )
            .state('whoWeAre',
                parent: 'layout',
                url: '/quisom',
                templateUrl: 'client/views/partials/who-we-are.html'
                controller: 'WhoWeAreCtrl'
            )
            .state('results',
                parent: 'layout',
                url: '/resultats',
                templateUrl: 'client/views/partials/resultats.html'
                controller: 'ResultsCtrl'
            )

        $urlRouterProvider.otherwise('/');

        $locationProvider.html5Mode(
            enabled: true
        )

    app.config(['$stateProvider', '$urlRouterProvider', '$locationProvider', Router])