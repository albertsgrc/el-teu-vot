# Layout controller

    LayoutCtrl = ($scope, $translate, $state, $rootScope) ->

## Header and navigation

Language setter

        $scope.setLanguage = (lang) ->
            $translate.use(lang)

Logo sizing

        $rootScope.$state = $state;

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

    app.controller('LayoutCtrl', ['$scope', '$translate', '$state', '$rootScope', LayoutCtrl])