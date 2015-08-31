# Angular route configuration

    Router = ($stateProvider, $urlRouterProvider, $locationProvider) ->
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
            .state('questions',
                parent: 'layout'
                abstract: true
                template: "<ui-view/>"
            )
            .state('politicalQuestions',
                controller: 'PoliticalQuestionsCtrl'
                parent: 'questions'
                url: '/questionari'
                templateUrl: 'client/views/partials/political-questions.html'
            )
            .state('personalQuestions',
                controller: 'PersonalQuestionsCtrl'
                parent: 'questions'
                url: '/questionari/'
                params: {
                    cameFromVerification: null
                }
                templateUrl: 'client/views/partials/personal-questions.html'
            )
            .state('results',
                parent: 'layout'
                url: '/resultats/:id'
                params: {
                    justCreated: null
                }
                templateUrl: 'client/views/partials/results.html'
                controller: 'ResultsCtrl'
            )

        $urlRouterProvider.otherwise('/');

        $locationProvider.html5Mode(
            enabled: true
        )

    app.config(['$stateProvider', '$urlRouterProvider', '$locationProvider', Router])