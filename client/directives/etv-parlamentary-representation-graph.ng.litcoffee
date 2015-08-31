# Parlamentary representation graph directive

    calculateSeats = (data) ->
        LEGAL_WALL = 0.03
        NUMBER_SEATS = 135

        votesSum = 0
        votesSum += party.value for party in data

        parties = {}
        voteValues = []

        for party in data
            if votesSum > 0 and party.value/votesSum >= LEGAL_WALL
                parties[party.party] = { votes: party.value, seats: 0 }
            else
                party.seats = 0

        for party, obj of parties
            for divider in [1..NUMBER_SEATS]
                voteValues.push { party: party, value: obj.votes/divider }

        voteValues.sort((a, b) ->
            if a.value is b.value
                votesA = parties[a.party].votes
                votesB = parties[b.party].votes
                if votesA is votesB
                    return Math.random()*2 - 1
                return votesB - votesA
            return b.value - a.value
        )

        for voteValue, i in voteValues
            break if i is NUMBER_SEATS
            ++parties[voteValue.party].seats

        for party, obj of parties
            for _party in data
                if _party.party is party
                    _party.seats = obj.seats

        parties



    parlamentaryRepresentationGraph = ($timeout, $compile, politicalPartiesService, resultsService) ->
        restrict: 'EA'

        scope: {}

        link: (scope, element, attrs) ->
            data = []
            partiesIds = []

            politicalPartiesService.getPoliticalParties().then(
                (politicalParties) ->
                    resultsService.getResults().then(
                        (results) ->
                            return unless results?

                            partiesIds = _.pluck(politicalParties, '_id')

                            for party in politicalParties
                                data.push(
                                    party: party._id
                                    color: party.color
                                    value: _.find(results.partyCoincidence, (elem) -> elem.party is party._id ).value
                                )

                            setGraph()
                    )
            )

            setGraph = ->
                partyToSeats = calculateSeats(data)

Half the number of 'escons' for every hemicycle level starting from level 0 (straight line)

                hemicycle = [3.5, 8, 9, 10, 7, 8, 8, 6, 5]
                hemicycleSeats = [7, 16, 18, 26, 20, 16, 16, 12, 10]

                paint = ->
                    parent = d3.select(element[0])

                    COLORS =
                        GREY: "#a7a9ac"

                    VIEWBOX_WIDTH = 635
                    VIEWBOX_HEIGHT = 635

                    ELLIPSE_CENTER_X = 318
                    ELLIPSE_CENTER_Y = 578

                    ELLIPSE_COUNT = 8

                    SPACE_BETWEEN_ELLIPSES = 31
                    SPACE_BETWEEN_ELLIPSE_CIRCLES = 3.55555555555555555555 + 0.416
                    SPACE_BETWEEN_LINE_CIRCLES = 24

                    CIRCLE_RADIUS = 12
                    CIRCLE_DIAMETER = 2*CIRCLE_RADIUS

                    INNERMOST_ELLIPSE_X_RADIUS = 151
                    INNERMOST_ELLIPSE_Y_RADIUS = 179

                    MIDDLE_CORRIDOR_CIRCLE_RADIUS = 2*CIRCLE_RADIUS/3


                    graphContainer = parent.append("div")
                    .attr("id", "parlamentaryRepresentationContainer")

                    svg = graphContainer.append("svg")
                    .attr("viewBox", "0 0 #{VIEWBOX_WIDTH} #{VIEWBOX_HEIGHT}")

                    paths = []

                    shapeEllipses = (obj, number) ->
                        shapeEllipse = (obj, rx, ry) ->
                            cx = ELLIPSE_CENTER_X
                            cy = ELLIPSE_CENTER_Y

                            obj.attr("d",
                                """
                                    M #{cx - rx}, #{cy}
                                    a #{rx}, #{ry} 0 1,0 #{2*rx},0
                                    a #{rx}, #{ry} 0 1,0 #{-2*rx},0
                                """)

                        for ellipse in [0..number-1]
                            path = obj.append("path").attr("fill", "none")
                            paths.push(path)

                            ellipseRadius = (baseRadius) ->
                                baseRadius + (SPACE_BETWEEN_ELLIPSES + CIRCLE_DIAMETER)*ellipse

                            xRadius = ellipseRadius(INNERMOST_ELLIPSE_X_RADIUS)
                            yRadius = ellipseRadius(INNERMOST_ELLIPSE_Y_RADIUS)
                            shapeEllipse(path, xRadius, yRadius)

                    path = svg.call(shapeEllipses, ELLIPSE_COUNT)

                    hemicycleVector = []

                    k = 0
                    putHemicycleCircles = ( ->
                        for path, it in paths
                            pathn = path.node()
                            l = pathn.getTotalLength()

                            pal = (length) -> pathn.getPointAtLength(length)

                            lengthTillNow = 0.5*l + CIRCLE_RADIUS

                            inRange = (v, a, b, offset = 0) -> offset + a <= v <= offset + b

                            shouldPutCircle = (hemicycleLevel, circleNumber, middleCircleNumber) ->
                                return false if circleNumber is middleCircleNumber
                                return true if inRange(circleNumber, -hemicycle[hemicycleLevel], hemicycle[hemicycleLevel], middleCircleNumber)
                                if hemicycleLevel is 4
                                    return true if inRange(circleNumber, -7, -5, middleCircleNumber-hemicycle[hemicycleLevel])
                                    return true if inRange(circleNumber, 5, 7, middleCircleNumber+hemicycle[hemicycleLevel])
                                return false

                            middleCircle = (level) -> 10 + level*3

                            i = 1; j = 0
                            while lengthTillNow < l
                                currentMiddleCircle = middleCircle(it)
                                radius = if i is currentMiddleCircle then MIDDLE_CORRIDOR_CIRCLE_RADIUS else CIRCLE_RADIUS

                                if shouldPutCircle(it + 1, i, currentMiddleCircle)
                                    cx = pal(lengthTillNow).x
                                    cy = pal(lengthTillNow).y

                                    circleElement = svg.append("circle")
                                    .attr("r", radius)
                                    .attr("cx", cx)
                                    .attr("cy", cy)

                                    hemicycleVector[k] =
                                        circle: circleElement
                                        cx: cx
                                        cy: cy

                                    ++j; ++k;
                                ++i
                                lengthTillNow += 2*radius + SPACE_BETWEEN_ELLIPSE_CIRCLES + it*(0.167 - it*0.013)
                    )()

                    putLineCircles = ( ->
                        nCircles = 2*hemicycle[0]
                        sideSpacing = (VIEWBOX_WIDTH - (CIRCLE_DIAMETER*nCircles + SPACE_BETWEEN_LINE_CIRCLES*(nCircles - 1)))/2

                        position = sideSpacing + CIRCLE_RADIUS

                        for circle in [1..nCircles]
                            cy = VIEWBOX_HEIGHT - CIRCLE_RADIUS - 2

                            circleElement = svg.append("circle")
                            .attr("r", CIRCLE_RADIUS)
                            .attr("cx", position)
                            .attr("cy", cy)

                            hemicycleVector[k] =
                                circle: circleElement
                                cx: position
                                cy: cy

                            position += CIRCLE_DIAMETER + SPACE_BETWEEN_LINE_CIRCLES
                            ++k
                    )()

                    paintCircles = ( ->
                        i = 0

                        partyToInfo = {}

                        for party in data
                            partyToInfo[party.party] = { color: party.color, seats: party.seats }


                        currentLevelPos = [0,0,0,0,0,0,0,0,0]

                        hemicycleVector.sort((a, b) ->
                            if b.cx is a.cx
                                return a.cy - b.cy
                            return b.cx - a.cx
                        )

                        for seat in hemicycleVector
                            partiesIds.shift() while partiesIds.length and partyToInfo[partiesIds[0]].seats is 0

                            break if partiesIds.length is 0

                            seat.circle.attr("fill", partyToInfo[partiesIds[0]].color)
                            --partyToInfo[partiesIds[0]].seats
                    )()

                    putLegend = ( ->
                        legendContainer = graphContainer
                        .append("div")
                        .attr("id", "parlamentaryRepresentationLegend")

                        legend = legendContainer.selectAll("div")
                        .data(-> return data.sort( (a, b) ->
                            return b.seats - a.seats
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
                        .html((d) -> (d.seats || 0))

                        $compile(angular.element(".legendPartyName"))(scope)
                    )()

                $timeout(paint)



    app.directive('etvParlamentaryRepresentationGraph', ['$timeout', '$compile', 'politicalPartiesService', 'resultsService', parlamentaryRepresentationGraph])