# Tooltip translation

    translateTooltip = ($translate) ->
        link: (scope, element, attrs) ->
            tooltipTranslation = $translate.instant(attrs.etvTranslateTooltip + 'Tooltip')

            updateTranslation = -> element.attr("title", $('<textarea />').html($translate.instant(attrs.etvTranslateTooltip + 'Tooltip')).text())

            if tooltipTranslation isnt attrs.etvTranslateTooltip + 'Tooltip'
                updateTranslation()
                scope.$on('languageChange', updateTranslation)

    app.directive('etvTranslateTooltip', ['$translate', translateTooltip])