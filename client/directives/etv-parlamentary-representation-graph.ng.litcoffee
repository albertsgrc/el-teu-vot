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

                paint = _.debounce( ->

                    parent = d3.select(element[0])

                    $(element[0]).empty()

                    containerSize = $(".graphContainer").width()

                    s = {}

                    ( calcSizes = (size, r) ->
                        r.circleRadius = ( ->
                            Math.min 12, size/60
                        )()

                        r.circleDiameter = 2*r.circleRadius

                        r.ellipseCount = ( ->
                            8
                        )()

                        r.ellipseToLineSpacing = ( ->
                            2.1*r.circleDiameter
                        )()

                        r.spaceBetweenEllipses = ( ->
                            (1.295)*r.circleDiameter
                        )()

                        r.spaceBetweenCircles = ( ->
                            (8/27)*r.circleRadius
                        )()

                        r.spaceBetweenLineCircles = ( ->
                            r.circleDiameter
                        )()

                        r.innerEllipseXRadius = ( ->
                            6.3*r.circleDiameter
                        )()

                        r.innerEllipseYRadius = ( ->
                            1.185*r.innerEllipseXRadius
                        )()

                        r.svgHeight = ( ->
                            Math.ceil 1+r.innerEllipseYRadius + (r.ellipseCount - 1)*(r.spaceBetweenEllipses) + r.ellipseCount*(r.circleDiameter) - r.circleRadius
                        )()

                        r.svgWidth = ( ->
                            1.1*r.svgHeight
                        )()

                        r.svgHeight += r.circleDiameter + r.ellipseToLineSpacing

                        r.ellipseCenter = ( ->
                            cx: r.svgWidth/2
                            cy: r.svgHeight - r.circleDiameter - r.ellipseToLineSpacing
                        )()

                    )(containerSize, s)

                    colors =
                        grey: "#a7a9ac"

                    graphContainer = parent.append("div")
                    .attr("id", "parlamentaryRepresentationContainer")
                    .style("display", "inline-block")


                    svg = graphContainer.append("svg")
                    .attr("width", s.svgWidth)
                    .attr("height", s.svgHeight)

                    paths = []

                    shapeEllipses = (obj, number) ->

                        shapeEllipse = (obj, rx, ry) ->
                            cx = s.ellipseCenter.cx
                            cy = s.ellipseCenter.cy

                            obj.attr("d",
                                    """
                                    M #{cx - rx}, #{cy}
                                    a #{rx}, #{ry} 0 1,0 #{2*rx},0
                                    a #{rx}, #{ry} 0 1,0 #{-2*rx},0
                                """)

                        for ellipse in [0..number-1]
                            path = obj.append("path")
                            paths.push(path)

                            ellipseRadius = (baseRadius) ->
                                baseRadius + (s.spaceBetweenEllipses + s.circleRadius*2)*ellipse
                            xRadius = ellipseRadius(s.innerEllipseXRadius)
                            yRadius = ellipseRadius(s.innerEllipseYRadius)
                            shapeEllipse(path, xRadius, yRadius)

                    path = svg
                    .call(shapeEllipses, s.ellipseCount)
                    .attr("stroke", "none")
                    .attr("fill", "none")

                    hemicycleVector = []


                    k = 0
                    putHemicycleCircles = ( ->
                        for path, it in paths
                            pathn = path.node()
                            l = pathn.getTotalLength()

                            pal = (length) -> pathn.getPointAtLength(length)

                            lengthTillNow = 0.5*l + s.circleRadius

                            inRange = (v, a, b, offset = 0) -> offset + a <= v <= offset + b

                            shouldPutCircle = (hemicycleLevel, circleNumber, middleCircleNumber) ->
                                return false if circleNumber is middleCircleNumber
                                if inRange(circleNumber, -hemicycle[hemicycleLevel], hemicycle[hemicycleLevel], middleCircleNumber)
                                    return true
                                return true if hemicycleLevel is 4 and inRange(circleNumber, -7, -5, middleCircleNumber-hemicycle[hemicycleLevel])
                                return true if hemicycleLevel is 4 and inRange(circleNumber, 5, 7, middleCircleNumber+hemicycle[hemicycleLevel])
                                return false

                            i = 1
                            j = 0
                            while lengthTillNow < l
                                if shouldPutCircle(it + 1, i, 10 + it*3)
                                    hemicycleVector[k] = svg.append("circle")
                                    .attr("fill", colors.grey)
                                    .attr("r", s.circleRadius)
                                    .attr("cx", pal(lengthTillNow).x)
                                    .attr("cy", pal(lengthTillNow).y)
                                    ++j

                                    ++k
                                ++i
                                lengthTillNow += s.circleDiameter + (s.spaceBetweenCircles + it*(s.spaceBetweenCircles/(3200/243) - it*s.spaceBetweenCircles/(20000/117)))
                    )()

                    putLineCircles = ( ->
                        nCircles = 2*hemicycle[0]
                        sideSpacing = (s.svgWidth - (s.circleDiameter*nCircles + s.spaceBetweenLineCircles*(nCircles - 1)))/2

                        position = sideSpacing + s.circleRadius
                        for circle in [1..nCircles]
                            hemicycleVector[k] = svg.append("circle")
                            .attr("r", s.circleRadius)
                            .attr("cx", position)
                            .attr("cy", s.svgHeight - s.circleRadius - 2)
                            position += s.circleDiameter + s.spaceBetweenLineCircles
                            ++k

                    )()

                    paintCircles = ( ->
                        i = 0

                        partyToInfo = {}

                        for party in data
                            partyToInfo[party.party] = { color: party.color, seats: party.seats }


                        currentLevelPos = [0,0,0,0,0,0,0,0,0]

                        hemicycleVector.sort((a, b) ->
                            if b.attr('cx') is a.attr('cx')
                                a.attr('cy') - b.attr('cy')
                            b.attr('cx') - a.attr('cx')
                        )

                        partiesCopy = JSON.parse(JSON.stringify(partiesIds))

                        for seat in hemicycleVector
                            partiesCopy.shift() while partiesCopy.length and partyToInfo[partiesCopy[0]].seats is 0

                            break if partiesCopy.length is 0

                            seat.attr("fill", partyToInfo[partiesCopy[0]].color)
                            --partyToInfo[partiesCopy[0]].seats

                    )()

                    putLegend = ( ->
                        legendContainer = graphContainer
                        .append("div")
                        .style("margin-top", "25px")
                        .style("margin-bottom", "2.5%")
                        .style("margin-left", "20px")
                        .style("margin-right", "20px")
                        .attr("id", "parlamentaryRepresentationLegend")

                        containerWidth = $("#resultsContainer").width() - 2 - 30

                        legend = legendContainer.selectAll("div")
                        .data(-> return data.sort( (a, b) ->
                            return b.seats - a.seats
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
                        .html((d) -> (d.seats || 0))

                        $compile(angular.element(".legendPartyName"))(scope)
                    )()
                , 250)

                $timeout(paint)
                scope.$on('resize', paint)



    app.directive('etvParlamentaryRepresentationGraph', ['$timeout', '$compile', 'politicalPartiesService', 'resultsService', parlamentaryRepresentationGraph])