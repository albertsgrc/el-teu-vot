# Layout controller

    LayoutCtrl = ($scope, $translate, $rootScope, $state, $window, $mdSidenav, $mdUtil, $mdMedia) ->

        $scope.socialClick = (socialMedia) ->
            switch socialMedia
                when "facebook" then $window.open 'http://www.facebook.com'
                when "twitter" then $window.open 'http://www.twitter.com'
            return true # Necessary for angular not to complain

        $scope.isCompact = $state.current.name is 'questions' or $mdMedia('max-width:700px')

        $scope.isHeaderFixed = $state.current.name is 'questions'

        $scope.isLogoCompact = $state.current.name isnt 'welcome' or $mdMedia('max-width:700px')

        $rootScope.$on('$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
            $scope.isHeaderFixed = toState.name is 'questions'
            $scope.isCompact = toState.name is 'questions' or $mdMedia('max-width: 700px')
            $scope.isLogoCompact = toState.name isnt 'welcome' or $mdMedia('max-width:700px')
        )

        $scope.setLanguage = (language) ->
            $translate.use(language)

        $scope.goTo = (state) -> $state.go(state)

        buildToggler = (navID) ->
            debounceFn = $mdUtil.debounce((->
                $mdSidenav(navID)
                .toggle()
            ), 300)

            return debounceFn

        $scope.toggleNav = buildToggler('right')


    app.controller('LayoutCtrl', ['$scope', '$translate', '$rootScope', '$state', '$window', '$mdSidenav','$mdUtil', '$mdMedia', LayoutCtrl])