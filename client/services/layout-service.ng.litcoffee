# Layout control and handling service

    LayoutService = ($window, $timeout) ->

        registerScrollListener = (callback) ->
            $timeout(callback)
            $window.on('scroll', callback)



    app.service('layoutService', ['$window', '$timeout', LayoutService])