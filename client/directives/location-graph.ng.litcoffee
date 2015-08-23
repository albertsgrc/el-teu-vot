# Location graph directive

    locationGraph = ($timeout, $compile) ->
        restrict: 'EA'

        scope: {}

        link: (scope, element, attrs) ->

            data =
                parties: [
                    {party: "ppc", color: "#37a7de", value: .20, nationalUbication: 4, ideologicalUbication: 6.61}
                    {party: "juntsPelSi", color: "#36b6a9", value: .45, nationalUbication: 10, ideologicalUbication: 4}
                    {party: "catalunyaSiQueEsPot", color: "#d80a30", value: .10, nationalUbication: 7, ideologicalUbication: 3}
                    {party: "psc", color: "#bc2025", value: .60, nationalUbication: 6, ideologicalUbication: 3.77}
                    {party: "cs", color: "#e64f24", value: .40, nationalUbication: 5.5, ideologicalUbication: 5.13 }
                    {party: "udc", color: "#2253a1", value: .50, nationalUbication: 7.5, ideologicalUbication: 6.3 }
                    {party: "cup", color: "#fee300", value: .05, nationalUbication: 10, ideologicalUbication: 2.23}
                ]

                user: [ { nationalUbication: 7, ideologicalUbication: 3 } ]

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
                .attr("cx", (d) -> s.xPosition(d.ideologicalUbication))
                .attr("cy", (d) -> s.yPosition(d.nationalUbication) )
                .attr("fill", (d) -> d.color )
                .attr("r", (d) -> s.radiusFactor*s.baseRadius)

                elTeuVot = svg.selectAll("image")
                .data(data.user)
                .enter()
                .append("image")
                .attr("x", (d) -> s.xPosition(d.ideologicalUbication, false, true))
                .attr("y", (d) -> s.yPosition(d.nationalUbication, false, true))
                .attr("width", s.radiusFactor*s.baseRadius*2)
                .attr("height", s.radiusFactor*s.baseRadius*2)
                .attr("xlink:href", "/images/etv-circle-logo.png")

Turns down el teu vot radius when it matches the position of a party

                fixCircleOverlapping = ( ->

                    for party in data.parties
                        if party.ideologicalUbication is data.user[0].ideologicalUbication and party.nationalUbication is data.user[0].nationalUbication
                            elTeuVot
                            .attr("x", (d) -> s.xPosition(d.ideologicalUbication, true, true))
                            .attr("y", (d) -> s.yPosition(d.nationalUbication, true, true))
                            .attr("width", s.radiusFactor*(s.baseRadius - s.positionMatchRadiusDecrease)*2)
                            .attr("height", s.radiusFactor*(s.baseRadius - s.positionMatchRadiusDecrease)*2)
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

                elTeuVotLegend.append("svg")
                .attr("width", 2*s.legendCircleRadius)
                .attr("height", s.legendHeight)
                .append("image")
                .attr("xlink:href", "/images/etv-circle-logo.png")
                .attr("x", "0")
                .attr("y", "#{(s.legendHeight - 2*s.legendCircleRadius)/2}")
                .attr("width", 2*s.legendCircleRadius)
                .attr("height", 2*s.legendCircleRadius)

                $compile(angular.element(".legendPartyName"))(scope)

            $timeout(paint)
            $(window).on('resize', paint)
            scope.$on('$destroy', -> $(window).off('resize load', paint))


    app.directive('locationGraph', ['$timeout', '$compile', locationGraph])