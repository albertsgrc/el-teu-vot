# Layout controller

    LayoutCtrl = ($scope, $translate, $rootScope, $state, $window) ->
        $scope.socialClick = (socialMedia) ->
            switch socialMedia
                when "facebook" then $window.open 'http://www.facebook.com'
                when "twitter" then $window.open 'http://www.twitter.com'
            return true # Necessary for angular not to complain

        $scope.isCompact = $state.current.name is 'questions'

        $scope.isLogoCompact = $state.current.name isnt 'welcome'

        $rootScope.$on('$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
            $scope.isCompact = toState.name is 'questions'
            $scope.isLogoCompact = toState.name isnt 'welcome'
        )

        $scope.setLanguage = (language) ->
            $translate.use(language)

        $scope.goTo = (state) -> $state.go(state)


    app.controller('LayoutCtrl', ['$scope', '$translate', '$rootScope', '$state', '$window', LayoutCtrl])