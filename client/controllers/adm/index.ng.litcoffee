# Administration page controller

    AdmCtrl = ($scope, $state, $meteor, topicsService, politicalPartiesService, questionsService, $translate) ->
        $scope.downloading = false
        $scope.error = false

        onLogout = ->
            $state.go('admLogin')

        $scope.logout = ->
            Meteor.logout(onLogout)

        translate = (text) -> $('<div/>').html($translate.instant(text)).text()


        toPqTitle = (text) ->
            text = text.replace(":", "")

            text = "Record de vot" if text.indexOf("Record de vot") >= 0
            text = "Intenció de vot" if text.indexOf("Intenció de vot") >= 0

            return text

        translateCsv = (csv) ->
            $translate.use('ca')

            csv = csv.replace(/^(.*)$/m, (match, word) ->
                return word.replace(/#tl([^#]*)#etl/gi, (match, word) ->
                    return toPqTitle(translate(word))
                )
            )

            csv = csv.replace(/#tl([^#]*)#etl/gi, (match, word) ->
                return translate(word)
            )

            csv


        downloadCsv = (csv) ->
            csv = translateCsv(csv)

            date = new Date
            dateString = "#{date.getHours()}:#{date.getMinutes()}_#{date.getDay()}-#{date.getMonth()}-#{date.getFullYear()}"

            blob = new Blob([csv], {type: "text/csv;charset=utf-8"})
            saveAs(blob, "resultats_etv_#{dateString}.csv")

            $scope.$apply( ->
                $scope.downloading = false
            )

        notifyError = (err) ->
            console.error err
            $scope.$apply( ->
                $scope.error = true
                $scope.downloading = false
            )

        $scope.downloadData = ->
            unless $scope.downloading
                $scope.downloading = true
                $scope.infoText = "S'estàn baixant les dades del servidor..."

                Meteor.call('getAllResults', (err, res) ->
                    $scope.infoText = "S'estàn processant les dades..."
                    $scope.$apply()
                    setTimeout( (-> if err then notifyError(err) else downloadCsv(res)), 200)
                )

    app.controller('AdmCtrl', ['$scope', '$state', '$meteor', 'topicsService', 'politicalPartiesService', 'questionsService', '$translate', AdmCtrl])