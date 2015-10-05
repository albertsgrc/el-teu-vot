# Meteor methods file

    jsZip = Meteor.npmRequire('jszip')

    isOlderThan = (minutesOld, date) ->
        now = new Date
        return now - date >= minutesOld*60000

    toCsv = (results) ->
        personalQuestions = _cc.PersonalQuestions.full
        topics = _cc.Topics.full
        translations = _cc.Translations.client

        csv = ""
        DELIMITER = ";"

        pqOrderById = {}
        for question in personalQuestions
            pqOrderById[question._id] = question.order

        localeOffsetInHours = ((new Date()).getTimezoneOffset() + 120)/60

        translate = (s) ->
            tr = translations[s]
            if tr
                if Array.isArray(tr) then tr[0] else tr
            else s

        addHeaders = ->
            csv += "Id"
            csv += "#{DELIMITER}Pregunta #{question}" for question in [1..23]
            csv += "#{DELIMITER}Ubicació ideològica#{DELIMITER}Ubicació nacional"
            csv += "#{DELIMITER}#{translate(topic._id)}" for topic in topics
            csv += "#{DELIMITER}#{translate(question._id + "Export")}" for question in personalQuestions.sort((a, b) -> a.order - b.order)
            csv += "#{DELIMITER}Data"

        addData = ->
            for result, i in results
                csv += "\n#{result._id}"

                for answer in result.political.basicAnswers.sort((a, b) -> b.number - a.number)
                    csv += "#{DELIMITER}#{answer.answer}"

                csv += "#{DELIMITER}#{result.political.ideologicalLocation}#{DELIMITER}#{result.political.nationalLocation}"

                for topic in topics
                    csv += "#{DELIMITER}#{Topics.TOPIC_WEIGHT_BY_ORDER_INDEX_STRING[result.political.topicOrder.indexOf(topic._id)]}"

                for answer in result.personal.answers.sort((a, b) -> pqOrderById[a.questionId] - pqOrderById[b.questionId])
                    csv += "#{DELIMITER}"
                    csv += "#{translate(answer.answer)}" if answer.answer

                date = new Date(result.createdAt)
                date.setUTCHours(date.getUTCHours() + localeOffsetInHours)

                pad = (n) -> if n < 10 then '0' + n else n

                csv += "#{DELIMITER}#{pad(date.getDate())}/#{pad(date.getMonth() + 1)}/#{date.getFullYear()} #{pad(date.getHours())}:#{pad(date.getMinutes())}:#{pad(date.getSeconds())}.#{(date.getMilliseconds()/ 1000).toFixed(3).slice(2, 5)}"

        addHeaders()
        addData()

        csv

    Meteor.methods(
        getAllResults: ->
            if @userId? and @userId is Meteor.users.findOne({ username: 'admin' })._id
                csv = toCsv(Results.find({}, { fields: { _id: 1, political: 1, personal: 1, createdAt: 1 }, sort: { createdAt: 1 } }).fetch())
                zip = new jsZip()
                zip.file('resultats.csv', csv)

                zip.generat e({ type: "base64", compression: "DEFLATE", compressionOptions: { level: 9 } })
            else
                throw new Meteor.Error("AUTH_ERROR", "NO_USER")

        getResults: (id) ->
            Results.findOne({ _id: id }, { fields: { partyCoincidence: 1, topicAndPartyCoincidence: 1, "political.ideologicalLocation": 1, "political.nationalLocation": 1, "political.topicOrder": 1 } })

        #getPoliticalParties: -> _cc.PoliticalParties.client

        #getPersonalQuestions: -> _cc.PersonalQuestions.client

        #getPoliticalQuestions: -> _cc.PoliticalQuestions.client

        #getTopics: -> _cc.Topics.client

        getTranslations: -> _cc.Translations.client

        updateCollectionCache: (collections...) -> CollectionCache.update(collections...)
    )