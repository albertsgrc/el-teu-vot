# Party coincidence graph directive

    calcSize = -> Math.min 550, 0.7*$("#resultsContainer").width()
    calcSpacing = (size) -> .022
    calcRadius = (size) -> size/2
    calcBlankSpacing = (size) -> .08
    calcFontSize = (size) -> 14

    calcBigFontSize = -> calcFontSize()*1.7

    calcSizes = ->
        width = calcSize()
        height = width
        spacing = calcSpacing(width)
        blankSpacing = calcBlankSpacing(width)
        radius = calcRadius(width)
        font = calcFontSize($("#resultsContainer").width())
        bigFont = font*1.7

        {
            width: width
            height: height
            spacing: spacing
            blankSpacing: blankSpacing
            radius: radius
            font: font
            bigFont: bigFont
        }

    topicCoincidenceGraphDirective = ($timeout, $translate, $compile, politicalPartiesService, resultsService) ->
        restrict: 'EA'
        scope: {
            topic: '@topicCoincidenceGraph'
        }

        link: (scope, element, attrs) ->
            results = []

            politicalPartiesService.getPoliticalParties().then(
                (politicalParties) ->
                    resultsService.getResults().then(
                        (data) ->
                            topicResultsInfo = _.find(data.topicAndPartyCoincidence, (elem) -> elem.topic is scope.topic).values

                            for party in politicalParties
                                results.push(
                                    party: party.id
                                    color: party.color
                                    value: _.find(topicResultsInfo, (elem) -> elem.party is party.id ).value
                                )
                    )
            )

            paint = ->

                $(element[0]).empty()

                self = @

                @sizes = calcSizes()

                title = d3.select(element[0])
                .append("p")
                .style("font-size", self.sizes.bigFont + "px")
                .style("color", "#a7a9ac")
                .attr("class", "text-uppercase topicGraphTitle")
                .style("margin-bottom", "30px", "important")
                .style("margin-left", "20px", "important")
                .style("margin-right", "20px", "important")
                .attr("translate", scope.topic)

                $compile(angular.element(".topicGraphTitle"))(scope)

                @arc = d3.svg.arc()
                .startAngle(0)
                .endAngle((d) -> d.value*2*Math.PI)
                .innerRadius((d) -> d.index*self.sizes.radius)
                .outerRadius((d) -> (d.index + self.sizes.spacing)*self.sizes.radius)

                @backgroundArc = d3.svg.arc()
                .startAngle(0)
                .endAngle((d) -> 2*Math.PI)
                .innerRadius((d) -> d.index*self.sizes.radius)
                .outerRadius((d) -> (d.index + self.sizes.spacing)*self.sizes.radius)

                @fields = ->
                    results.sort( (a, b) ->
                        return a.value - b.value
                    )

                    index = 1 - self.sizes.blankSpacing*results.length
                    for obj in results
                        obj.index = index
                        index += self.sizes.blankSpacing

                    return results

                @svg = d3.select(element[0])
                .append("svg")
                .attr("width", self.sizes.width)
                .attr("height", self.sizes.height)
                .append("g")
                .attr("transform", "translate(#{self.sizes.width/2},#{self.sizes.height/2})")

                @field = svg.selectAll("g")
                .data(fields)
                .enter().append("g")

                @field.append("path")
                .attr("d", self.backgroundArc)
                .style("fill", "#e6e6e7")

                @field.append("path")
                .attr("d", self.arc)
                .style("fill", (d) -> d.color)

                legendContainer = d3.select(element[0])
                .append("div")
                .style("margin-top", "5%")
                .style("margin-bottom", "2.5%")
                .style("margin-left", "20px")
                .style("margin-right", "20px")
                .attr("id", "topicCoincidenceLegend")

                containerWidth = $("#resultsContainer").width() - 2 - 30

                legend = legendContainer.selectAll("div")
                .data(-> return results.sort( (a, b) ->
                    return b.value - a.value
                ))
                .enter().append("div")
                .attr("class", "legendPartyContainer")
                .style("margin-bottom", "10px")
                .style("margin-left", "8px")
                .style("margin-right", "8px")

                partyName = legend.append("p")
                .attr("class", "legendPartyName")
                .attr("translate", (d) -> "{{ '#{d.party}' }}" )
                .attr("etv-translate-tooltip", (d) -> d.party)

                legend.append("p")
                .attr("class", "legendPercentage")
                .style("color", (d) -> d.color)
                .html((d) -> "#{+(d.value*100).toFixed(1)} %")

                $compile(angular.element(".legendPartyName"))(scope)


            $timeout(paint)
            scope.$on('layoutChange', paint)

    app.directive('topicCoincidenceGraph', ['$timeout', '$translate', '$compile', 'politicalPartiesService', 'resultsService', topicCoincidenceGraphDirective])