# Sortable directive

    sortableDirective = ->
        restrict: 'EA'
        replace: true
        templateUrl: "client/views/components/etv-sortable.html"

        link: (scope, element, attrs) ->
            element.find("ul").sortable({
                tolerance: 'touch'
                cancel: ''
                disabled: true
            })

    app.directive('etvSortable', [sortableDirective])