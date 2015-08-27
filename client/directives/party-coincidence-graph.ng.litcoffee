# Party coincidence graph directive

    partyCoincidenceGraphDirective = ($timeout, $translate, $compile, politicalPartiesService, resultsService) ->
        restrict: 'EA'
        scope: {}
        link: (scope, element, attrs) ->
            data = []

            politicalPartiesService.getPoliticalParties().then(
                (parties) ->
                    resultsService.getResults().then(
                        (results) ->
                            return unless results?

                            for party in parties
                                data.push(
                                    party: party.id
                                    color: party.color
                                    value: _.find(results.partyCoincidence, (elem) -> elem.party is party.id ).value
                                )

                            data.sort( (a, b) -> b.value - a.value )

                            $timeout(paint)
                    )
            )

            paint = ->

                parent = d3.select(element[0])

                containerSize = $(".graphContainer").width()

                sizes = ( (size) ->
                    r = {}

                    r.parentTopPadding = 45

                    r.radius = 60
                    r.donutWidth = 25
                    r.size = r.radius*2
                    r.donutSideMargin = 15
                    r.donutBottomMargin = 50
                    r.donutToLegendSpacing = 25

                    r.legendHeight = 25
                    r.font = 14

                    r
                )(containerSize)

                parent.style("padding-top", "#{sizes.parentTopPadding}px")

                arc = d3.svg.arc()
                .startAngle(0)
                .outerRadius(sizes.radius)
                .innerRadius(sizes.radius - sizes.donutWidth)

                donutContainer = parent.selectAll("div")
                .data( -> data )
                .enter()
                .append("div")
                .style("display", "inline-block")
                .style("min-width", "#{sizes.size}px")
                .style("margin-left", "#{sizes.donutSideMargin}px")
                .style("margin-right", "#{sizes.donutSideMargin}px")
                .style("margin-bottom", "#{sizes.donutBottomMargin}px")

                donut = donutContainer
                .append("svg")
                .attr("width", sizes.size)
                .attr("height", sizes.size)
                .style("display", "block")
                .style("margin", "auto")
                .append("g")
                .attr("transform", "translate(#{sizes.radius}, #{sizes.radius})")

                legend = donutContainer
                .append("div")
                .attr("class", "legendPartyContainer")
                .style("margin-top", "#{sizes.donutToLegendSpacing}px")

                partyName = legend.append("p")
                .attr("class", "legendPartyName")
                .attr("translate", (d) -> "{{ '#{d.party}' }}" )
                .attr("etv-translate-tooltip", (d) -> d.party)

                legend.append("p")
                .attr("class", "legendPercentage")
                .style("color", (d) -> d.color)
                .html((d) -> "#{+(d.value*100).toFixed(1)} %")


Background arc

                donut.append("path")
                .attr("d", arc.endAngle((d) -> 2*Math.PI))
                .style("fill", "#e6e6e7")

Colored and valued arc

                donut.append("path")
                .attr("d", arc.endAngle((d) -> d.value*2*Math.PI))
                .style("fill", (d) -> d.color)

                $compile(angular.element(".legendPartyName"))(scope)


    app.directive('partyCoincidenceGraph', ['$timeout', '$translate', '$compile', 'politicalPartiesService', 'resultsService', partyCoincidenceGraphDirective])