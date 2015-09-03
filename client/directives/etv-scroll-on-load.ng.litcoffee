# Etv scroll on load element directive

    scrollOnLoad = ->
        restrict: 'A'
        link: (scope, element, attrs) ->
            if not attrs.etvScrollOnLoad.length or attrs.etvScrollOnLoad is "true"
                SCROLL_ANIMATION_TIME = 400

                offset = $(element).offset().top - $("header.fixedHeader").outerHeight(true)

                $('html, body').animate({ scrollTop: offset }, SCROLL_ANIMATION_TIME)

    app.directive('etvScrollOnLoad', scrollOnLoad)