# Location graph directive

    locationGraph = ($timeout, $compile, resultsService, politicalPartiesService) ->
        restrict: 'EA'

        scope: {}

        link: (scope, element, attrs) ->

            data =
                parties: []
                user: []

            politicalPartiesService.getPoliticalParties().then(
                (politicalParties) ->

                    resultsService.getResults().then(
                        (results) ->

                            for party in politicalParties
                                data.parties.push(
                                    party: party._id
                                    color: party.color
                                    nationalLocation: party.nationalLocation
                                    ideologicalLocation: party.ideologicalLocation
                                )

                            data.user.push(
                                nationalLocation: results.political.nationalLocation
                                ideologicalLocation: results.political.ideologicalLocation
                            )

                            $timeout(paint)
                            scope.$on('resize', paint)
                    )
            )

            paint = ->

                parent = d3.select(element[0])

                $(element[0]).empty()

                containerSize = $(".graphContainer").width()

                s = {}

                ( calcSizes = (size, r) ->
                    r.leftRightGraphMargin = ( ->
                        if window.innerWidth <= 550
                            15
                        else
                            Math.min(80, size/7)
                    )()

                    r.axisIndicatorTextSpacing = ( ->
                        Math.min 18, size/4
                    )()

                    r.font = ( ->
                       14
                    )()

                    r.svgSize = ( ->
                        Math.min(500, size - 2*(r.leftRightGraphMargin + r.axisIndicatorTextSpacing))
                    )()

                    r.axisWidth = ( ->
                        1
                    )()

                    r.baseRadius = ( ->
                        10
                    )()

                    r.radiusFactor = ( ->
                        return size/340 if window.innerWidth <= 550
                        return Math.min(1.6, size/390)
                    )()

                    r.maxRadius = ( ->
                        r.radiusFactor*r.baseRadius
                    )()

                    r.graphToLegendSpacing = ( ->
                        Math.min(75, size/10)
                    )()

                    r.legendHeight = ( ->
                        25
                    )()

                    r.legendCircleRadius = ( ->
                        8
                    )()

                    r.positionMatchRadiusDecrease = ( ->
                        3
                    )()

                    r.position = (value, decreased, image) ->
                        increase = if decreased then r.radiusFactor*r.positionMatchRadiusDecrease else 0
                        offset = if image then 0 else r.maxRadius
                        rangeDecrease = 2*r.maxRadius
                        offset + (r.svgSize - rangeDecrease)*value/10 + increase

                    r.xPosition = r.position
                    r.yPosition = (value, decreased, image) -> r.position(10 - value, decreased, image)

                    r
                )(containerSize, s)

                colors =
                    grey: "#a7a9ac"

                graphContainer = parent.append("div")
                .attr("id", "locationGraphContainer")
                .style("width", "#{s.svgSize}px")
                .style("height", "#{s.svgSize}px")
                .style("display", "inline-block")
                .style("position", "relative")
                .style("margin-left", "#{s.leftRightGraphMargin}px")
                .style("margin-right", "#{s.leftRightGraphMargin}px")

Axis texts

                axisText = graphContainer.selectAll("p")
                .data(["left", "right", "independentism", "unionism"])
                .enter()
                .append("p")
                .style("position", "absolute")
                .attr("class", (d) ->

                    specialClass =
                        switch d
                            when "left" then d
                            when "right" then d
                            when "independentism" then "top"
                            when "unionism" then "bottom"

                    "#{specialClass} axisIndicator"
                )
                .style("left", (d) ->
                    if d is "left"
                        "#{-s.axisIndicatorTextSpacing}px"
                    else null
                )
                .style("right", (d) ->
                    if d is "right"
                        "#{-s.axisIndicatorTextSpacing}px"
                    else null
                )
                .style("top", (d) ->
                    if d is "independentism"
                        "#{-s.axisIndicatorTextSpacing}px"
                    else null
                )
                .style("bottom", (d) ->
                    if d is "unionism"
                        "#{-s.axisIndicatorTextSpacing}px"
                    else null
                )
                .style("color", colors.grey)
                .style("margin-bottom", "0", "important")
                .style("font-size", "#{s.font}px")
                .attr("translate", (d) -> "{{ '#{d}' }}")

                $compile(angular.element(".axisIndicator"))(scope)

                svg = graphContainer.append("svg")
                .attr("width", s.svgSize)
                .attr("height", s.svgSize)

Horizontal axis

                svg.append("line")
                .attr("x1", 0)
                .attr("y1", s.svgSize/2)
                .attr("x2", s.svgSize)
                .attr("y2", s.svgSize/2)
                .attr("stroke", colors.grey)
                .attr("stroke-width", s.axisWidth)

Vertical axis

                svg.append("line")
                .attr("x1", s.svgSize/2)
                .attr("y1", 0)
                .attr("x2", s.svgSize/2)
                .attr("y2", s.svgSize)
                .attr("stroke", colors.grey)
                .attr("stroke-width", s.axisWidth)

Circles

                svg.selectAll("circle")
                .data(data.parties)
                .enter()
                .append("circle")
                .attr("cx", (d) -> s.xPosition(d.ideologicalLocation))
                .attr("cy", (d) -> s.yPosition(d.nationalLocation) )
                .attr("fill", (d) -> d.color )
                .attr("r", (d) -> s.radiusFactor*s.baseRadius)

                elTeuVot = graphContainer.selectAll("img")
                .data(data.user)
                .enter()
                .append("img")
                .attr("src", "/images/etv-circle-logo.png")
                .style("position", "absolute")
                .style("left", (d) -> s.xPosition(d.ideologicalLocation, false, true) + "px")
                .style("top", (d) -> s.yPosition(d.nationalLocation, false, true) + "px")
                .style("width", s.radiusFactor*s.baseRadius*2 + "px")
                .style("height", s.radiusFactor*s.baseRadius*2 + "px")

Turns down el teu vot radius when it matches the position of a party

                fixCircleOverlapping = ( ->

                    for party in data.parties
                        if party.ideologicalLocation is data.user[0].ideologicalLocation and party.nationalLocation is data.user[0].nationalLocation
                            elTeuVot
                            .style("left", (d) -> s.xPosition(d.ideologicalLocation, true, true) + "px")
                            .style("top", (d) -> s.yPosition(d.nationalLocation, true, true) + "px")
                            .style("width", s.radiusFactor*(s.baseRadius - s.positionMatchRadiusDecrease)*2 + "px")
                            .style("height", s.radiusFactor*(s.baseRadius - s.positionMatchRadiusDecrease)*2 + "px")

                            return

                )()

Legend

                legendContainer = parent.append("div")
                .style("margin-top", "#{s.graphToLegendSpacing}px")
                .style("margin-bottom", "30px")
                .style("margin-left", "20px")
                .style("margin-right", "20px")


                legend = legendContainer.selectAll("div")
                .data(-> return data.parties.sort( (a, b) ->
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

                legend.append("svg")
                .attr("width", 2*s.legendCircleRadius)
                .attr("height", s.legendHeight)
                .append("circle")
                .style("fill", (d) -> d.color)
                .attr("cx", s.legendCircleRadius )
                .attr("cy", s.legendHeight/2 )
                .attr("r", s.legendCircleRadius)

El teu vot image and location circle

                elTeuVotLegend = legendContainer.insert("div", ":first-child")
                .attr("class", "legendPartyContainer")
                .style("margin-bottom", "10px")
                .style("margin-left", "8px")
                .style("margin-right", "8px")

                elTeuVotLegend.append("p")
                .attr("class", "legendPartyName")
                .attr("translate", (d) -> "{{ 'elTeuVot' }}" )

                elTeuVotLegend.append("img")
                .attr("src", "/images/etv-circle-logo.png")
                .style("width", (2*s.legendCircleRadius + 1) + "px")
                .style("height", (2*s.legendCircleRadius + 1) + "px")
                .style("float", "right")
                .style("margin-top", "4px")

                $compile(angular.element(".legendPartyName"))(scope)


    app.directive('etvLocationGraph', ['$timeout', '$compile', 'resultsService', 'politicalPartiesService', locationGraph])