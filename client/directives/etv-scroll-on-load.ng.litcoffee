# Etv scroll on load element directive

    scrollOnLoad = ->
        restrict: 'A'
        link: (scope, element, attrs) ->
            SCROLL_ANIMATION_TIME = 400

            graphOffset = $(element).offset().top - $("header.fixedHeader").outerHeight(true)

            $('html, body').animate({ scrollTop: graphOffset }, SCROLL_ANIMATION_TIME)

    app.directive('etvScrollOnLoad', scrollOnLoad)