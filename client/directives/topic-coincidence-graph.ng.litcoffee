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

    topicCoincidenceGraphDirective = ($timeout, $translate, $compile) ->
        restrict: 'EA'
        scope: {}
        link: (scope, element, attrs) ->
            paint = ->
                $(element[0]).empty()

                self = @

                @sizes = calcSizes()

                title = "Economia i Estat del Benestar"

                d3.select(element[0])
                .append("p")
                .style("font-size", self.sizes.bigFont + "px")
                .style("color", "#a7a9ac")
                .attr("class", "text-uppercase")
                .style("margin-bottom", "30px", "important")
                .style("margin-left", "20px", "important")
                .style("margin-right", "20px", "important")
                .html(title)

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

                results = [
                    {party: "ppc", color: "#37a7de", value: .20 }
                    {party: "juntsPelSi", color: "#36b6a9", value: .45 }
                    {party: "catalunyaSiQueEsPot", color: "#d80a30", value: .10 }
                    {party: "psc", color: "#bc2025", value: .60 }
                    {party: "cs", color: "#e64f24", value: .40 }
                    {party: "udc", color: "#2253a1", value: .15 }
                    {party: "cup", color: "#fee300", value: .05 }
                ]

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

                legend.append("p")
                .attr("class", "legendPercentage")
                .style("color", (d) -> d.color)
                .html((d) -> d.value*100 + "%")

                $compile(angular.element(".legendPartyName"))(scope)


            $timeout(paint)
            $(window).on('resize', paint)
            scope.$on('$destroy', -> $(window).off('resize load', paint))

    app.directive('topicCoincidenceGraph', ['$timeout', '$translate', '$compile', topicCoincidenceGraphDirective])