# Angular route configuration

    Router = ($stateProvider, $urlRouterProvider, $locationProvider) ->
        # TODO: Make main state and put header and footer inside it
        $stateProvider
            .state('layout',
                abstract: true,
                templateUrl: 'client/views/partials/layout.html',
                controller: 'LayoutCtrl'
            )
            .state('welcome',
                parent: 'layout',
                url: '/',
                templateUrl: 'client/views/partials/welcome.html',
                controller: 'WelcomeCtrl'
            )
            .state('questions',
                parent: 'layout',
                url: '/preguntes',
                templateUrl: 'client/views/partials/questions.html',
                controller: 'QuestionsCtrl'
            )
            .state('yourVote',
                parent: 'layout',
                url: '/elteuvot',
                templateUrl: 'client/views/partials/yourVote.html'
                controller: 'YourVoteCtrl'
            )
            .state('methodology',
                parent: 'layout',
                url: '/metodologia',
                templateUrl: 'client/views/partials/methodology.html'
                controller: 'MethodologyCtrl'
            )
            .state('whoAreWe',
                parent: 'layout',
                url: '/quisom',
                templateUrl: 'client/views/partials/whoAreWe.html'
                controller: 'WhoAreWeCtrl'
            )

        $urlRouterProvider.otherwise('/');

        $locationProvider.html5Mode(
            enabled: true
        )

    app.config(['$stateProvider', '$urlRouterProvider', '$locationProvider', Router])