# Fills the database with the data if currently empty

    createTopics = ->
        TOPICS = [
            "regeneracioDemocratica"
            "modelTerritorial"
            "estatDelBenestar"
            "ciutadania"
            "territoriEcologiaIMediAmbient"
        ]

        for topic in TOPICS
            unless Topics.findOne({ _id: topic })?
                Topics.insert({ _id: topic }, (err, result) ->
                    console.error(err) if err
                )


    createPoliticalParties = ->
        POLITICAL_PARTIES = [
            { _id: "JxS", color: "#36b6a9", ideologicalLocation: 4, nationalLocation: 10 }
            { _id: "CSQEP", color: "#d80a30", ideologicalLocation: 3, nationalLocation: 7 }
            { _id: "CUP", color: "#fee300", ideologicalLocation: 2.23, nationalLocation: 10 }
            { _id: "PPC", color: "#37a7de", ideologicalLocation: 6.61, nationalLocation: 4 }
            { _id: "PSC", color: "#bc2025", ideologicalLocation: 3.77, nationalLocation: 6 }
            { _id: "Cs", color: "#e64f24", ideologicalLocation: 5.13, nationalLocation: 5.5 }
            { _id: "UDC", color: "#2253a1", ideologicalLocation: 6.3, nationalLocation: 7.5 }
        ]

        for party in POLITICAL_PARTIES
            unless PoliticalParties.findOne({ _id: party._id })?
                PoliticalParties.insert(party, (err, res) ->
                    console.error err if err
                )

    createPoliticalQuestions = ->
        POLITICAL_QUESTIONS = [
            { type: "basic", topic: "regeneracioDemocratica", answerResemblanceToPartyMatrix:
                """
                    JxS 0 0.2 5 4 1

                    CSQEP 0 0.2 1 5 4

                    CUP 0 0.2 1 5 4

                    PP 5 4 1 0.2 0

                    PSC 0 0.2 1 4 5

                    C’S 0 0.2 4 5 1

                    UDC 5 4 1 0.2 0
                """
            }
            { type: "basic", topic: "regeneracioDemocratica", answerResemblanceToPartyMatrix:
                """
                    JxS 0 0.2 1 5 4

                    CSQEP 0 0.2 1 4 5

                    CUP 0 0.2 1 4 5

                    PP 0 0.2 5 4 1

                    PSC 0 0.2 1 5 4

                    C’S 0 0.2 1 5 4

                    UDC 0 0.2 4 5 1
                """
            }
            { type: "basic", topic: "regeneracioDemocratica", answerResemblanceToPartyMatrix:
                """
                    JxS 0 0.2 1 5 4

                    CSQEP 0 0.2 1 4 5

                    CUP 0 0.2 1 4 5

                    PP 0 0.2 5 4 1

                    PSC 0 0.2 1 5 4

                    C’S 0 0.2 1 5 4

                    UDC 0 0.2 4 5 1
                """
            }
            { type: "basic", topic: "regeneracioDemocratica", answerResemblanceToPartyMatrix:
                """
                    JxS 0 0.2 1 5 4

                    CSQEP 0 0.2 1 4 5

                    CUP 0 0.2 1 4 5

                    PP 5 4 1 0.2 0

                    PSC 0 5 4 1 0.2

                    C’S 4 5 1 0.2 0

                    UDC 0 0.2 4 5 1
                """
            }
            { type: "basic", topic: "modelTerritorial", answerResemblanceToPartyMatrix:
                """
                    JxS 5 4 1 0.2 0

                    CSQEP 0 0.2 4 5 1

                    CUP 5 4 1 0.2 0

                    PP 0 0.2 1 5 4

                    PSC 0 0.2 1 5 4

                    C’S 0 5 4 1 0.2

                    UDC 0 0.2 4 5 1
                """
            }
            { type: "basic", topic: "modelTerritorial", answerResemblanceToPartyMatrix:
                """
                    JxS 0 0.2 1 4 5

                    CSQEP 0.2 4 5 1 0

                    CUP 0 0.2 1 4 5

                    PP 5 4 1 0.2 0

                    PSC 5 4 1 0.2 0

                    C’S 5 4 1 0.2 0

                    UDC 4 5 1 0.2 0
                """
            }
            { type: "basic", topic: "modelTerritorial", answerResemblanceToPartyMatrix:
                """
                    JxS 5 4 1 0.2 0

                    CSQEP 4 5 1 0.2 0

                    CUP 5 4 1 0.2 0

                    PP 0 0.2 1 4 5

                    PSC 0 5 4 1 0.2

                    C’S 0 0.2 1 5 4

                    UDC 1 5 4 0.2 0
                """
            }
            { type: "basic", topic: "modelTerritorial", answerResemblanceToPartyMatrix:
                """
                    JxS 0 0.2 1 4 5

                    CSQEP 0 0.2 1 4 5

                    CUP 0 0.2 1 4 5

                    PP 5 4 1 0.2 0

                    PSC 0 0.2 1 4 5

                    C’S 5 4 1 0.2 0

                    UDC 0 0.2 1 4 5
                """
            }
            { type: "basic", topic: "modelTerritorial", answerResemblanceToPartyMatrix:
                """
                    JxS 5 4 1 0.2 0

                    CSQEP 4 1 5 0.2 0

                    CUP 0.2 4 5 1 0

                    PP 0 0.2 1 4 5

                    PSC 4 5 1 0.2 0

                    C’S 0 0.2 1 4 5

                    UDC 5 4 1 0.2 0
                """
            }
            { type: "basic", topic: "modelTerritorial", answerResemblanceToPartyMatrix:
                """
                    JxS 0 0.2 1 4 5

                    CSQEP 0 0.2 1 5 4

                    CUP 0 0.2 1 4 5

                    PP 5 4 1 0.2 0

                    PSC 0 0.2 1 4 5

                    C’S 5 4 1 0.2 0

                    UDC 0 0.2 1 4 5
                """
            }
            { type: "basic", topic: "estatDelBenestar", answerResemblanceToPartyMatrix:
                """
                    JxS 4 5 1 0.2 0

                    CSQEP 5 4 1 0.2 0

                    CUP 5 4 1 0.2 0

                    PP 0.2 1 4 5 0

                    PSC 4 5 1 0.2 0

                    C’S 0 1 5 4 0.2

                    UDC 4 5 1 0.2 0
                """
            }
            { type: "basic", topic: "estatDelBenestar", answerResemblanceToPartyMatrix:
                """
                    JxS 0 0.2 1 5 4

                    CSQEP 0 0.2 1 4 5

                    CUP 0 0.2 1 4 5

                    PP 0 5 1 4 0.2

                    PSC 0 0.2 1 4 5

                    C’S 0 0.2 1 5 4

                    UDC 0 0.2 1 5 4
                """
            }
            { type: "basic", topic: "estatDelBenestar", answerResemblanceToPartyMatrix:
                """
                    JxS 0.2 4 5 1 0

                    CSQEP 5 4 1 0.2 0

                    CUP 5 4 1 0.2 0

                    PP 0 0.2 1 4 5

                    PSC 0.2 5 1 4 0

                    C’S 0.2 5 4 1 0

                    UDC 0 0.2 1 5 4
                """
            }
            { type: "basic", topic: "estatDelBenestar", answerResemblanceToPartyMatrix:
                """
                    JxS 0.2 4 5 1 0

                    CSQEP 5 4 1 0.2 0

                    CUP 5 4 1 0.2 0

                    PP 0 0.2 1 4 5

                    PSC 1 5 4 0.2 0

                    C’S 0 0.2 1 5 4

                    UDC 1 4 5 0.2 0
                """
            }
            { type: "basic", topic: "ciutadania", answerResemblanceToPartyMatrix:
                """
                    JxS 0 0.2 5 4 1

                    CSQEP 0 0.2 1 4 5

                    CUP 0 0.2 1 4 5

                    PP 5 4 1 0.2 0

                    PSC 0 0.2 1 5 4

                    C’S 0 0.2 4 5 1

                    UDC 0 1 4 5 0.2
                """
            }
            { type: "basic", topic: "ciutadania", answerResemblanceToPartyMatrix:
                """
                    JxS 4 5 1 0.2 0

                    CSQEP 5 4 1 0.2 0

                    CUP 5 4 1 0.2 0

                    PP 0 0.2 1 5 4

                    PSC 4 5 1 0.2 0

                    C’S 4 5 1 0.2 0

                    UDC 0 0.2 1 5 4
                """
            }
            { type: "basic", topic: "ciutadania", answerResemblanceToPartyMatrix:
                """
                    JxS 4 5 1 0.2 0

                    CSQEP 5 4 1 0.2 0

                    CUP 5 4 1 0.2 0

                    PP 0 0.2 1 5 4

                    PSC 4 5 1 0.2 0

                    C’S 5 4 1 0.2 0

                    UDC 0 0.2 1 5 4
                """
            }
            { type: "basic", topic: "ciutadania", answerResemblanceToPartyMatrix:
                """
                    JxS 0 0.2 1 4 5

                    CSQEP 0 0.2 1 4 5

                    CUP 0 0.2 1 4 5

                    PP 5 4 1 0.2 0

                    PSC 0 0.2 1 4 5

                    C’S 0 0.2 1 5 4

                    UDC 5 4 1 0.2 0
                """
            }
            { type: "basic", topic: "ciutadania", answerResemblanceToPartyMatrix:
                """
                    JxS 5 4 1 0.2 0

                    CSQEP 5 4 1 0.2 0

                    CUP 5 4 1 0.2 0

                    PP 0 0.2 1 4 5

                    PSC 4 5 1 0.2 0

                    C’S 0.2 4 5 1 0

                    UDC 1 5 4 0.2 0
                """
            }
            { type: "basic", topic: "ciutadania", answerResemblanceToPartyMatrix:
                                                  """
                    JxS 5 4 1 0.2 0

                    CSQEP 5 4 1 0.2 0

                    CUP 5 4 1 0.2 0

                    PP 0 0.2 1 4 5

                    PSC 4 5 1 0.2 0

                    C’S 0.2 4 5 1 0

                    UDC 1 5 4 0.2 0
                """
            }
            { type: "basic", topic: "territoriEcologiaIMediAmbient", answerResemblanceToPartyMatrix:
                """
                    JxS 0 0.2 1 5 4

                    CSQEP 0 0.2 1 4 5

                    CUP 0 0.2 1 4 5

                    PP 1 5 4 0.2 0

                    PSC 0 0.2 4 5 1

                    C’S 0 0.2 1 4 5

                    UDC 0 0.2 4 5 1
                """
            }
            { type: "basic", topic: "territoriEcologiaIMediAmbient", answerResemblanceToPartyMatrix:
                """
                    JxS 0 0.2 1 5 4

                    CSQEP 0 0.2 1 4 5

                    CUP 0 0.2 1 4 5

                    PP 0.2 1 4 5 0

                    PSC 0 0.2 1 4 5

                    C’S 0 0.2 1 4 5

                    UDC 0 0.2 1 5 4
                """
            }
            { type: "basic", topic: "territoriEcologiaIMediAmbient", answerResemblanceToPartyMatrix:
                """
                    JxS 0 1 4 5 0.2

                    CSQEP 0 0.2 1 4 5

                    CUP 0 0.2 1 4 5

                    PP 5 4 1 0.2 0

                    PSC 0 0.2 1 4 5

                    C’S 0 0.2 4 5 1

                    UDC 0 0.2 5 4 1
                """
            }
            {
                type: "ideologicalLocation"
            }
            {
                type: "nationalLocation"
            }
            {
                type: "topicSort"
            }
        ]

        for pq in POLITICAL_QUESTIONS when pq.type is "basic"
            txt = pq.answerResemblanceToPartyMatrix
            pq.answerResemblanceToPartyMatrix = []
            i = 0
            for line in txt.split("\n")
                continue if line is "" or line is " "
                lineElems = line.split(" ")
                party = lineElems.shift()
                party = "Cs" if party is "C’S"
                party = "PPC" if party is "PP"

                lineElems[i] = Number(elem) for elem, i in lineElems
                values = lineElems
                pq.answerResemblanceToPartyMatrix.push { party: party, resemblanceToAnswers: values }

        politicalQuestion.number = i + 1 for politicalQuestion, i in POLITICAL_QUESTIONS

        for pq in POLITICAL_QUESTIONS
            unless PoliticalQuestions.findOne({ number: pq.number })?
                PoliticalQuestions.insert(pq, (err, res) ->
                    if err
                        console.error(err.invalidKeys)
                        shouldReturn = true
                )

    createPersonalQuestions = ->
        PERSONAL_QUESTIONS = [
            { _id: "age", mandatory: true, type: "button", order: 1, options: [
                "<18"

                "18-24"

                "25-34"

                "35-44"

                "45-54"

                "55-64"

                "+64"
                ]
            }
            { _id: "genre", mandatory: true, type: "button", order: 2, options:  [
                "male"
                "female"
                "otherSex"
                ]
            }
            { _id: "postalCode", mandatory: true, type: "input", order: 3, validate: "^([1-9]{2}|[0-9][1-9]|[1-9][0-9])[0-9]{3}$", errorMessageId: "incorrectPostalCode" }

            { _id: "educationLevel", mandatory: false, type: "button", order: 4, options:  [
                "noStudies"
                "primaryStudies"
                "secondaryStudies"
                "professionalFormation"
                "superiorStudies"
                "postgraduateStudies"
                ]
            }
            { _id: "cotidianLanguage", mandatory: false, type: "button", order: 5, options:  [
                "catalan"
                "spanish"
                "bothLanguages"
                ]
            }
            { _id: "votingRecord", mandatory: false, type: "button", order: 6, options: [
                "CIU"
                "Cs"
                "CUP"
                "ERC"
                "ICV-EUIA"
                "PPC"
                "PSC"
                "otherVotingRecord"
                "white"
                "null"
                "abstention"
                "nsnc"
                ]
            }
            { _id: "votingIntention", mandatory: false, type: "button", order: 7, options: [
                "Cs"
                "CSQEP"
                "CUP"
                "JxS"
                "PPC"
                "PSC"
                "UDC"
                "otherVotingRecord"
                "white"
                "null"
                "abstention"
                "nsnc"
                ]
            }
        ]


        for question in PERSONAL_QUESTIONS
            unless PersonalQuestions.findOne({ _id: question._id })?
                PersonalQuestions.insert(question, (err, res) ->
                    console.error(err) if err
                )


    Meteor.startup( ->
        createTopics()
        createPoliticalParties()
        createPoliticalQuestions()
        createPersonalQuestions()
    )

