# Layout controller

    LayoutCtrl = ($scope, $translate, $state, $rootScope, $window, questionsService, topicsService, politicalPartiesService) ->

## Header and navigation

        $rootScope.isFixedHeader = -> not $state.includes('elTeuVot')

        $rootScope.hasSidenav = -> $state.includes('questions') || $state.includes('results')

Language setter

        $scope.setLanguage = (lang) ->
            ga('send', 'event', 'button', 'click', "translation to #{lang}")
            $translate.use(lang)
            $rootScope.$broadcast('languageChange')

Viewport size

        ( ->
            e = window
            a = 'inner'

            unless 'innerWidth' of window
                a = 'client'
                e = document.documentElement || document.body

            { width: e["#{a}Width"], height: e["#{a}Height"] }
        )()

Opening and closing sidenav

        toggle = ->
            $("#sideNavContainer").animate({ width: "toggle", "max-width": "toggle", "min-width": "toggle" }, 150, "linear");
            return true

        $scope.closeSidenav = ->
            return if $("#sideNavContainer").css("display") is "none"

            $(document).unbind("click")
            toggle()

        $scope.openSidenav = ->
            return if $("#sideNavContainer").css("display") isnt "none"

            toggle()

            setCloseListener = ->
                $(document).unbind("click").on("click", (e) ->
                    if not ($(e.target).is("#sideNavContainer") or $(e.target).is("#menuButton")) and not ($(e.target).parents().is("#sideNavContainer") || $(e.target).parents().is("#menuButton"))
                        $scope.closeSidenav()
                )

            setCloseListener()

            return true

        $scope.hideSidenav = ->
            return if $("#sideNavContainer").css("display") is "none"

            $(document).unbind("click")
            $("#sideNavContainer").css({ "display": "none" })
            return true

        angular.element($window).on('resize', -> $rootScope.$broadcast('resize'))
        angular.element($window).on('load', -> $rootScope.$broadcast('load'))
        angular.element($window).on('scroll', -> $rootScope.$broadcast('scroll'))

    app.controller('LayoutCtrl', ['$scope', '$translate', '$state', '$rootScope', '$window', 'questionsService', 'topicsService', 'politicalPartiesService', LayoutCtrl])