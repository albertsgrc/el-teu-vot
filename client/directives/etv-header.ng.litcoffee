# Header directive

    headerDirective = ($window, $state) ->
        replace: true,
        restrict: 'E',
        templateUrl: "client/views/components/etv-header.html"

        link: (scope, element, attrs) ->
            isScrollOnTop = -> $window.scrollY is 0

            SMALL_HEADER_LOGO = "/images/etv_logo_abreviat.png"
            NORMAL_HEADER_LOGO = "/images/logo.png"

            scope.facebookUrl = "https://www.facebook.com/elteuvot"
            scope.twitterUrl = "https://twitter.com/elteuvot"

            scope.smallHeader = false

            scope.isSmallHeader = -> scope.smallHeader and scope.isFixedHeader() and not isScrollOnTop()

            scope.logoUrl = -> if scope.isSmallHeader() then SMALL_HEADER_LOGO else NORMAL_HEADER_LOGO

            updateHeader = ->
                if scope.isFixedHeader()
                    if not isScrollOnTop()
                        unless scope.smallHeader
                            scope.$apply( ->
                                scope.smallHeader = true
                            )


                    else
                        if scope.smallHeader
                            scope.$apply( ->
                                scope.smallHeader = false
                            )

            scope.$on('scroll', updateHeader)

    app.directive('etvHeader', ['$window', '$state', headerDirective])