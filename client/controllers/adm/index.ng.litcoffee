# Administration page controller

    AdmCtrl = ($scope, $state, $meteor, topicsService, politicalPartiesService, questionsService, $translate) ->
        $scope.downloading = false
        $scope.error = false

        onLogout = ->
            $state.go('admLogin')

        $scope.logout = ->
            Meteor.logout(onLogout)

        downloadCsv = (csv) ->
            date = new Date
            dateString = "#{date.getHours()}:#{date.getMinutes()}_#{date.getDay()}-#{date.getMonth()}-#{date.getFullYear()}"

            base64ToBlob = (base64String) ->
                byteCharacters = atob(base64String)
                byteNumbers    = new Array(byteCharacters.length)
                i              = 0
                while i < byteCharacters.length
                    byteNumbers[i] = byteCharacters.charCodeAt(i)
                    i++
                byteArray = new Uint8Array(byteNumbers)
                return blob = new Blob([byteArray],
                    type: "zip"
                )

            blob = base64ToBlob(csv)

            saveAs(blob, "resultats_etv_#{dateString}.zip")

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
                $scope.error = false
                $scope.downloading = true
                $scope.infoText = "S'estàn baixant les dades del servidor..."

                Meteor.call('getAllResults', (err, res) ->
                    $scope.infoText = "S'estàn processant les dades..."
                    $scope.$apply()
                    setTimeout( (-> if err then notifyError(err) else downloadCsv(res)), 200)
                )

    app.controller('AdmCtrl', ['$scope', '$state', '$meteor', 'topicsService', 'politicalPartiesService', 'questionsService', '$translate', AdmCtrl])