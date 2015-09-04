# Administration page controller

    AdmCtrl = ($scope, $state, $meteor, topicsService, politicalPartiesService, questionsService, $translate) ->
        $scope.downloading = false

        onLogout = ->
            $state.go('admLogin')

        $scope.logout = ->
            Meteor.logout(onLogout)

        topics = null
        politicalParties = null
        personalQuestions = null

        translate = (text) -> $('<div/>').html($translate.instant(text)).text()

        quote = (text) -> "\"#{text}\""

        toPqTitle = (text) ->
            text = text.replace(":", "")

            text = "Record de vot" if text.indexOf("Record de vot") >= 0
            text = "Intenció de vot" if text.indexOf("Intenció de vot") >= 0

            return text

        toCsv = (results) ->
            $translate.use('ca')

            columns = []
            columns.push quote("id")
            columns.push quote("Pregunta #{question}") for question in [1..23]
            columns.push quote("Ubicació ideològica")
            columns.push quote("Ubicació nacional")
            columns.push quote(translate(topic._id)) for topic in topics
            columns.push quote(toPqTitle(translate(question._id))) for question in personalQuestions
            columns.push quote("Data")

            csv = ""
            csv += columns.join(",")

            resultsArray = []

            arrayFromResult = (result) ->
                array = []

                array.push quote(result._id)

                for answer in result.political.basicAnswers.sort((a, b) -> b.number - a.number)
                    array.push quote(answer.answer)

                array.push quote(result.political.ideologicalLocation)
                array.push quote(result.political.nationalLocation)

                for topic in topics
                    array.push(quote(Topics.TOPIC_WEIGHT_BY_ORDER_INDEX[result.political.topicOrder.indexOf(topic._id)].toString().replace(".", ",")))

                for answer in result.personal.answers
                    array.push quote(translate(answer.answer))

                date = new Date(result.createdAt)

                pad = (n, width, z = '0') ->
                    n = n + '';
                    return (if n.length >= width then n else new Array(width - n.length + 1).join(z) + n)

                array.push quote("#{pad(date.getDate(), 2)}/#{pad(date.getMonth() + 1,2)}/#{pad(date.getFullYear(), 4)} #{pad(date.getHours(), 2)}:#{pad(date.getMinutes(), 2)}:#{pad(date.getSeconds(), 2)}.#{pad(date.getMilliseconds(), 3)}")

                array


            resultsArray.push(arrayFromResult(result)) for result in results

            for array in resultsArray
                csv += "\n"
                csv += array.join(",")

            csv


        downloadCsv = (results) ->
            date = new Date
            dateString = "#{date.getHours()}:#{date.getMinutes()}_#{date.getDay()}-#{date.getMonth()}-#{date.getFullYear()}"

            csv = toCsv(results)

            blob = new Blob([csv], {type: "text/csv;charset=utf-8"})
            saveAs(blob, "resultats_etv_#{dateString}.csv")

            $scope.downloading = false

        $scope.downloadData = ->
            unless $scope.downloading
                $scope.downloading = true
                topicsService.getTopics().then(
                    (_topics) ->
                        topics = _topics
                        politicalPartiesService.getPoliticalParties().then(
                            (_politicalParties) ->
                                politicalParties = _politicalParties
                                questionsService.getPersonalQuestions().then(
                                    (_personalQuestions) ->
                                        personalQuestions = _personalQuestions
                                        $meteor.call('getAllResults').then(downloadCsv)
                                )
                        )
                )

    app.controller('AdmCtrl', ['$scope', '$state', '$meteor', 'topicsService', 'politicalPartiesService', 'questionsService', '$translate', AdmCtrl])