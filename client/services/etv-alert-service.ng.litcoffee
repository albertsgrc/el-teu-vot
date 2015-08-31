# Etv alert service

    etvAlertService = ($rootScope, $compile) ->
        alertOpened = false

        self = @

        currentText = null

        closeUnlessAlert = (e) ->
            unless $(e.target).is(".modal-content") or $(e.target).parents().is(".modal-content")
                self.closeAlert()

        @openAlert = (text) ->
            unless alertOpened
                currentText = text
                $("body").append("<etv-alert class='etv-alert' style='display: block' text=\"{{ '#{text}' | translate }}\"/>")
                $compile(angular.element(".etv-alert"))($rootScope)
                $(".etv-alert").modal("show")
                alertOpened = true
                setTimeout((-> $("body").on('click', closeUnlessAlert)), 300)
            else if text? and text isnt currentText
                currentText = text
                self.closeAlert()
                self.openAlert(text)


        @closeAlert = ->
            if alertOpened
                $("body").off('click', closeUnlessAlert)
                $(".etv-alert").modal("hide")
                $(".etv-alert").remove()
                alertOpened = false

        $rootScope.$on('$stateChangeStart', ->
            self.closeAlert()
        )

        @

    app.service('etvAlertService', ['$rootScope', '$compile', etvAlertService])