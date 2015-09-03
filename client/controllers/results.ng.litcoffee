# Results page angular controller

    ResultsCtrl = ($scope, $translate, graphService, topicsService, resultsService, politicalPartiesService, $stateParams, $location, etvAlertService) ->
        ga('send', 'pageview', { 'page': '/resultats', 'title': "Resultats #{if $stateParams.justCreated then 'desde qüestionari' else 'desde fora'}" })

        $scope.loadingCounter = 3
        $scope.validResultsId = false
        $scope.error = false

        NProgress.start()

        onDataLoad = ->
            --$scope.loadingCounter
            NProgress.done() unless $scope.loadingCounter

        notifyError = ->
            console.error "Error loading results data"
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
            ga('send', 'event', 'click', 'share-results')
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

        isIe = ->
            ua = window.navigator.userAgent
            return ua.indexOf("MSIE ") > 0 or ua.indexOf(" Edge") > 0

        $scope.downloadGraph = (graphName) ->
            if isIe()
                ga('send', 'event', 'click', 'download-graph-not-supported')
                etvAlertService.openAlert("downloadForIeNotSupported")
                return true
            else
                ga('send', 'event', 'click', 'download-graph')
                scroll = $(window).scrollTop()
                $(window).scrollTop(0)

                html2canvas($("##{graphName}"),
                    onrendered: (canvas) ->
                        canvas.toBlob((blob) ->
                            saveAs(blob, "etv_#{$translate.instant(graphName + "Download")}.png")
                        )
                        $(window).scrollTop(scroll)

                    background: "white"
                    allowTaint: true
                )

        $scope.$on('$destroy', -> graphService.reset())


    app.controller('ResultsCtrl', ['$scope', '$translate', 'graphService', 'topicsService', 'resultsService', 'politicalPartiesService', '$stateParams', '$location', 'etvAlertService', ResultsCtrl])