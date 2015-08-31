# Party coincidence graph directive

    topicCoincidenceGraphDirective = ($timeout, $compile, politicalPartiesService, resultsService) ->
        restrict: 'EA'
        scope: {
            topic: '@etvTopicCoincidenceGraph'
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
                                    party: party._id
                                    color: party.color
                                    value: _.find(topicResultsInfo, (elem) -> elem.party is party._id ).value
                                )

                            $timeout(paint)
                    )
            )

            paint = ->
                results.sort( (a, b) ->
                    return a.value - b.value
                )

                ARC_OFFSET = 0.05

                OUTERMOST_INNER_RADIUS = 250

                VIEWBOX_SIZE = 500

                ARC_SPACING = .022

                BLANK_SPACING = .08

                unless attrs.miniature?
                    title = d3.select(element[0])
                    .append("p")
                    .attr("class", "text-uppercase topicGraphTitle")
                    .attr("translate", scope.topic)

                    $compile(angular.element(".topicGraphTitle"))(scope)

                arc = d3.svg.arc()
                .startAngle(0)
                .innerRadius((d) -> d.index*OUTERMOST_INNER_RADIUS)
                .outerRadius((d) -> (d.index + ARC_SPACING)*OUTERMOST_INNER_RADIUS)

                index = 1 - BLANK_SPACING*results.length
                for obj in results
                    obj.index = index
                    index += BLANK_SPACING

                svg = d3.select(element[0])
                .append("svg")
                .attr("viewBox", "0 0 #{VIEWBOX_SIZE} #{VIEWBOX_SIZE}")
                .attr("width", "100%")
                .append("g")
                .attr("transform", "translate(#{VIEWBOX_SIZE/2},#{VIEWBOX_SIZE/2})")

                field = svg.selectAll("g")
                .data(results)
                .enter().append("g")

                field.append("path")
                .attr("d", arc.endAngle((d) -> 2*Math.PI))
                .style("fill", "#e6e6e7")

                field.append("path")
                .attr("d", arc.endAngle((d) -> ARC_OFFSET + d.value*(2*Math.PI - ARC_OFFSET)))
                .style("fill", (d) -> d.color)

legend

                unless attrs.miniature?
                    legendContainer = d3.select(element[0])
                    .append("div")
                    .attr("id", "topicCoincidenceLegend")

                    legend = legendContainer.selectAll("div")
                    .data(-> return results.sort( (a, b) ->
                        return b.value - a.value
                    ))
                    .enter().append("div")
                    .attr("class", "legendPartyContainer")

                    partyName = legend.append("p")
                    .attr("class", "legendPartyName")
                    .attr("translate", (d) -> "{{ '#{d.party}' }}" )
                    .attr("etv-translate-tooltip", (d) -> d.party)

                    legend.append("p")
                    .attr("class", "legendPercentage")
                    .style("color", (d) -> d.color)
                    .html((d) -> "#{+(d.value*100).toFixed(1)} %")

                    $compile(angular.element(".legendPartyName"))(scope)

    app.directive('etvTopicCoincidenceGraph', ['$timeout', '$compile', 'politicalPartiesService', 'resultsService', topicCoincidenceGraphDirective])