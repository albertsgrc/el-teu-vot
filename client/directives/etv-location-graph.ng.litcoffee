# Location graph directive

    locationGraph = ($timeout, $compile, resultsService, politicalPartiesService) ->
        restrict: 'EA'

        scope: {}

        link: (scope, element, attrs) ->

            data =
                parties: []
                user: []

            computeData = (politicalParties, results) ->
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

            politicalPartiesService.getPoliticalParties().then(
                (politicalParties) ->
                    resultsService.getResults().then(
                        (results) ->
                            computeData(politicalParties, results)
                            paint()
                    )
            )

            paint = ->
                VIEWBOX_SIZE = 500

                WRAPPER_SIZE = VIEWBOX_SIZE + 5

                AXIS_WIDTH = if attrs.miniature? then 3 else 1

                CIRCLE_OVERLAP_RADIUS_DECREASE = 5

                CIRCLE_RADIUS = 15

                WRAPPER_WHOLE = 100

                COLORS =
                    GREY: "#a7a9ac"

                parent = d3.select(element[0])

                wrapper = parent.append("div")
                .attr("id", "locationGraphSvgWrapper")

                svg = wrapper.append("svg")
                .attr("id", "locationGraphSvg")
                .attr("width", "100%")
                .attr("viewBox", "0 0 #{VIEWBOX_SIZE} #{VIEWBOX_SIZE}")

                horizontalAxis = svg.append("line")
                .attr("x1", 0)
                .attr("y1", VIEWBOX_SIZE/2)
                .attr("x2", VIEWBOX_SIZE)
                .attr("y2", VIEWBOX_SIZE/2)
                .attr("stroke", COLORS.GREY)
                .attr("stroke-width", AXIS_WIDTH)

                verticalAxis = svg.append("line")
                .attr("x1", VIEWBOX_SIZE/2)
                .attr("y1", 0)
                .attr("x2", VIEWBOX_SIZE/2)
                .attr("y2", VIEWBOX_SIZE)
                .attr("stroke", COLORS.GREY)
                .attr("stroke-width", AXIS_WIDTH)

                normalizeRadius = (radius) -> 100*radius/WRAPPER_SIZE

                position = (value, decreased, image, yAxis) ->
                    if image then return (100 - 2*normalizeRadius(CIRCLE_RADIUS))*value/10 + (if decreased then normalizeRadius(CIRCLE_OVERLAP_RADIUS_DECREASE) else 0)
                    else return CIRCLE_RADIUS + (VIEWBOX_SIZE - 2*CIRCLE_RADIUS)*value/10

                xPosition = position

                yPosition = (value, decreased, image) -> position(10 - value, decreased, image, true)

                circle = svg.selectAll("circle")
                .data(data.parties)
                .enter()
                .append("circle")
                .attr("class", "locationCircle")
                .attr("cx", (d) -> xPosition(d.ideologicalLocation) )
                .attr("cy", (d) -> yPosition(d.nationalLocation) )
                .attr("fill", (d) -> d.color )
                .attr("r", (d) -> CIRCLE_RADIUS)

                $compile(angular.element(".locationCircle"))(scope)

                data.user[0].decreased = false

                for party in data.parties
                    if party.ideologicalLocation is data.user[0].ideologicalLocation and party.nationalLocation is data.user[0].nationalLocation
                        data.user[0].decreased = true
                        break

                elTeuVotCircle = wrapper.selectAll("img")
                .data(data.user)
                .enter()
                .append("img")
                .attr("id", "elTeuVotCircle")
                .attr("src", "/images/etv-circle-logo.png")
                .style("width", (d) -> "#{2*normalizeRadius(CIRCLE_RADIUS - (if d.decreased then CIRCLE_OVERLAP_RADIUS_DECREASE else 0))}%")
                .style("height", (d) -> "#{2*normalizeRadius(CIRCLE_RADIUS - (if d.decreased then CIRCLE_OVERLAP_RADIUS_DECREASE else 0))}%")
                .style("left", (d) -> "#{xPosition(d.ideologicalLocation, d.decreased, true)}%")
                .style("top", (d) -> "#{yPosition(d.nationalLocation, d.decreased, true)}%")
                .style("margin-top", (d) -> "#{5*d.nationalLocation/10}px")

                unless attrs.miniature?
                    legendContainer = parent.append("div")
                    .attr("class", "legend")

                    legendData = []

                    legendData.push
                        text: "elTeuVot"
                        image: "/images/etv-circle-logo.png"
                        etv: true

                    for elem in data.parties.sort( (a, b) -> return b.value - a.value )
                        legendData.push(
                            text: elem.party
                            color: elem.color
                        )

                    legend = legendContainer.selectAll("div")
                    .data(legendData)
                    .enter().append("div")
                    .attr("class", "legendPartyContainer")

                    partyName = legend.append("p")
                    .attr("class", "legendPartyName")
                    .attr("translate", (d) -> "#{d.text}" )
                    .attr("etv-translate-tooltip", (d) -> if d.etv then undefined else d.text)

                    legend
                    .filter((d) -> d.etv)
                    .append("div")
                    .attr("class", "locationLegendCircle")
                    .style("background-image", (d) -> "url('#{d.image}')")

                    legend.append("div")
                    .attr("class", "locationLegendCircle")
                    .filter((d) -> not d.etv)
                    .append("svg")
                    .attr("viewBox", "0 0 100 100")
                    .attr("width", "100%")
                    .append("circle")
                    .attr("r", "49")
                    .attr("cx", "50")
                    .attr("cy", "50")
                    .attr("fill", (d) -> d.color)

                    $compile(angular.element(".legendPartyName"))(scope)


                    axisText = wrapper.selectAll("p")
                    .data(["left", "right", "independentism", "unionism"])
                    .enter()
                    .append("p")
                    .style("position", "absolute")
                    .attr("class", (d) ->
                        specialClass =
                            switch d
                                when "left", "right" then d
                                when "independentism" then "top"
                                when "unionism" then "bottom"

                        "#{specialClass} axisIndicator"
                    )
                    .attr("translate", (d) -> "#{d}")

                    $compile(angular.element(".axisIndicator"))(scope)




    app.directive('etvLocationGraph', ['$timeout', '$compile', 'resultsService', 'politicalPartiesService', locationGraph])