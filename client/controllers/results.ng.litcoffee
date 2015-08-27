# Results page angular controller

    ResultsCtrl = ($scope, $translate, $window, graphService, topicsService, resultsService, $stateParams, $location) ->
        topicsService.getTopics().then( (results) -> $scope.topics = results )

        $scope.loading = true
        $scope.validResultsId = false

        resultsService.getResults($stateParams.id).then(
            (result) ->
                $scope.loading = false

                $scope.validResultsId = result?
                if $scope.validResultsId
                    $scope.results = result
        )

        $scope.justCreated = $stateParams.justCreated

        $scope.link = $location.absUrl()

        $scope.toggleGraph = graphService.toggleGraph

        $scope.openedGraphs = graphService.getOpenedGraphs()

        $scope.shareGraph = (socialMedia, graphName) ->

            url = $scope.link
            url = encodeURIComponent(url) if socialMedia is "twitter"

            socialUrl =
                switch socialMedia
                    when "facebook"
                        "https://www.facebook.com/sharer/sharer.php?u="
                    when "twitter"
                        "https://twitter.com/intent/tweet?url="

            link = d3.select("body").append("a")
            .attr("id", "graphShareLink")
            .attr("target", "_blank")
            .attr("href", socialUrl + url)

            $("#graphShareLink")[0].click()
            $("#graphShareLink").remove()

            return true

        $scope.downloadGraph = (graphName) ->
            scroll = $(window).scrollTop()
            $(window).scrollTop(0)

            html2canvas($("##{graphName}"),
                onrendered: (canvas) ->

                    link = d3.select("body").append("a").attr("id", "graphDownloadLink")
                    link.attr('download', "#{$translate.instant(graphName + "Download")}.png")
                    link.attr('href', canvas.toDataURL("image/png").replace("image/png", "image/octet-stream"))
                    $("#graphDownloadLink")[0].click()
                    $("#graphDownloadLink").remove()
                    $(window).scrollTop(scroll)

                background: "white"
            )


    app.controller('ResultsCtrl', ['$scope', '$translate', '$window', 'graphService', 'topicsService', 'resultsService', '$stateParams', '$location', ResultsCtrl])