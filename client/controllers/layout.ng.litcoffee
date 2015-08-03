# Layout controller

    LayoutCtrl = ($scope, $translate, $state, $rootScope) ->

## Header and navigation

Language setter

        $scope.setLanguage = (lang) ->
            $translate.use(lang)

Logo sizing

        $rootScope.$state = $state;

Opening and closing sidenav

        $scope.toggleSidenav = ->

            # TODO: This is a bug source and needs to be reorganized

            toggle = _.debounce( ->
                $("#sideNavContainer").animate({ width: "toggle", "max-width": "toggle", "min-width": "toggle" }, 150, "linear");
            , 200)


            hideDiv = (e) ->
                $(document).unbind("click")
                if $(e.target).is("button")
                    $("#sideNavContainer").css({ "display": "none" })
                    return

                if not ($(e.target).is("#sideNavContainer") or $(e.target).is("#menuButton")) and not ($(e.target).parents().is("#sideNavContainer") || $(e.target).parents().is("#menuButton"))
                    toggle()


            toggle()

            $(document).unbind("click").on("click", (e) ->
                hideDiv(e)
            )
            return true

    app.controller('LayoutCtrl', ['$scope', '$translate', '$state', '$rootScope', LayoutCtrl])