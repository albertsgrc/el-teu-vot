# General utilities

    @etvPrint = (elem) -> JSON.stringify(elem, null, 2)

    ###
    @etvHaveSameStringElements = (arrayA, arrayB) ->
        if arrayA.length is arrayB.length
            setA = {}
            setA[elem] = true for elem in arrayA

            for elem in arrayB
                return false unless setA[elem]

            return true

        else return false

    @etvArrayShuffle = (array) ->
        length = array.length

        while length > 0
            index = Math.floor(Math.random()*length)
            --length
            temp = array[length]
            array[length] = array[index]
            array[index] = temp

        return array

    @etvRandomResults = (cb) ->
        results = {}
        Meteor.call('getTopics', (err, topics) ->
            Meteor.call('getPersonalQuestions', (err2, personalQuestions) ->
                Meteor.call('getPoliticalQuestions', (err3, politicalQuestions) ->
                    results =
                        sessionId: Random.id()
                        political:
                            ideologicalLocation: Random.choice([0..10])
                            nationalLocation: Random.choice([0..10])
                            topicOrder: _.pluck(etvArrayShuffle(topics), '_id')
                            basicAnswers: []
                        personal:
                            answers: []

                    for question in politicalQuestions when question.type is "basic"
                        results.political.basicAnswers.push({
                            questionId: question._id
                            number: question.number
                            answer: Random.choice(PoliticalQuestions.BASIC_QUESTION_OPTIONS)
                        })

                    for question in personalQuestions
                        answer = undefined

                        if question.type isnt "input"
                            if question.mandatory or Random.choice([0,1]) is 1
                                answer = Random.choice(question.options)
                        else
                            answer = ""
                            for number in [1..5]
                                answer += Random.choice([1..9]).toString()

                        results.personal.answers.push({
                            questionId: question._id
                            answer: answer
                        })

                    cb(results)
                )
            )
        )
    ###