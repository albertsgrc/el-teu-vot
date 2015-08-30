# Results page angular controller

    ResultsCtrl = ($scope, $translate, graphService, topicsService, resultsService, politicalPartiesService, $stateParams, $location) ->
        $scope.loadingCounter = 3
        $scope.validResultsId = false
        $scope.error = false

        NProgress.start()

        onDataLoad = ->
            --$scope.loadingCounter
            NProgress.done() unless $scope.loadingCounter

        notifyError = ->
            $scope.error = true
            NProgress.done()

        topicsService.getTopics().then(
            (results) ->
                $scope.topics = results
                onDataLoad()
            ,
            notifyError
        )

        politicalPartiesService.getPoliticalParties().then(
            (result) ->
                onDataLoad()
            notifyError
        )

        resultsService.getResults($stateParams.id).then(
            (result) ->
                $scope.validResultsId = result?
                if $scope.validResultsId
                    $scope.results = result
                onDataLoad()
            ,
            notifyError
        )

        $scope.shouldShowBadIdMessage = -> not $scope.loadingCounter and not $scope.validResultsId

        $scope.shouldShowLoading = ->  $scope.loadingCounter > 0 and not $scope.error

        $scope.shouldShowResults = -> not $scope.loadingCounter and $scope.validResultsId

        $scope.shouldShowError = -> $scope.error

        $scope.GRAPHS = ['partyCoincidence', 'topicCoincidence', 'location', 'parlamentaryRepresentation']

        $scope.justCreated = $stateParams.justCreated

        $scope.resultsTitle = if $scope.justCreated then 'yourResultsTitle' else 'yourResultsTitleOut'

        $scope.resultsIntroText = if $scope.justCreated then 'yourResultsText' else 'yourResultsTextOut'

        $scope.link = $location.absUrl()

        $scope.isGraphOpened = graphService.isGraphOpened

        $scope.toggleGraph = graphService.toggleGraph

        $scope.openedGraphs = graphService.getOpenedGraphs()

        $scope.scrollToGraph = graphService.scrollToGraph

        $scope.imageSrc = (miniature) -> "/images/graph_min_#{miniature}_bg.png"

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

        $scope.$on('$destroy', -> graphService.reset())


    app.controller('ResultsCtrl', ['$scope', '$translate', 'graphService', 'topicsService', 'resultsService', 'politicalPartiesService', '$stateParams', '$location', ResultsCtrl])