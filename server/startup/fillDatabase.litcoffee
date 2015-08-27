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
            unless Topics.findOne({ id: topic })?
                Topics.insert({ id: topic }, (err, result) ->
                    console.error(err) if err
                )


    createPoliticalParties = ->
        POLITICAL_PARTIES = [
            { id: "JxS", color: "#36b6a9", ideologicalLocation: 4, nationalLocation: 10 }
            { id: "CSQEP", color: "#d80a30", ideologicalLocation: 3, nationalLocation: 7 }
            { id: "CUP", color: "#fee300", ideologicalLocation: 2.23, nationalLocation: 10 }
            { id: "PPC", color: "#37a7de", ideologicalLocation: 6.61, nationalLocation: 4 }
            { id: "PSC", color: "#bc2025", ideologicalLocation: 3.77, nationalLocation: 6 }
            { id: "Cs", color: "#e64f24", ideologicalLocation: 5.13, nationalLocation: 5.5 }
            { id: "UDC", color: "#2253a1", ideologicalLocation: 6.3, nationalLocation: 7.5 }
        ]

        for party in POLITICAL_PARTIES
            unless PoliticalParties.findOne({ id: party.id })?
                PoliticalParties.insert(party, (err, res) ->
                    console.error err if err
                )

    createPoliticalQuestions = ->
        POLITICAL_QUESTIONS = [
            { type: "basic", topic: "regeneracioDemocratica", answerResemblanceToPartyMatrix:
                """
                    JxS 1 2 5 4 3

                    CSQEP 1 2 3 5 4

                    CUP 1 2 3 5 4

                    PP 5 4 3 2 1

                    PSC 1 2 3 4 5

                    C’S 1 2 4 5 3

                    UDC 5 4 3 2 1
                """
            }
            { type: "basic", topic: "regeneracioDemocratica", answerResemblanceToPartyMatrix:
                """
                    JxS 1 2 3 5 4

                    CSQEP 1 2 3 4 5

                    CUP 1 2 3 4 5

                    PP 1 2 5 4 3

                    PSC 1 2 3 5 4

                    C’S 1 2 3 5 4

                    UDC 1 2 4 5 3
                """
            }
            { type: "basic", topic: "regeneracioDemocratica", answerResemblanceToPartyMatrix:
                """
                    JxS 1 2 3 5 4

                    CSQEP 1 2 3 4 5

                    CUP 1 2 3 4 5

                    PP 1 2 5 4 3

                    PSC 1 2 3 5 4

                    C’S 1 2 3 5 4

                    UDC 1 2 4 5 3
                """
            }
            { type: "basic", topic: "regeneracioDemocratica", answerResemblanceToPartyMatrix:
                """
                    JxS 1 2 3 5 4

                    CSQEP 1 2 3 4 5

                    CUP 1 2 3 4 5

                    PP 5 4 3 2 1

                    PSC 1 5 4 3 2

                    C’S 4 5 3 2 1

                    UDC 1 2 4 5 3
                """
            }
            { type: "basic", topic: "modelTerritorial", answerResemblanceToPartyMatrix:
                """
                    JxS 5 4 3 2 1

                    CSQEP 1 2 4 5 3

                    CUP 5 4 3 2 1

                    PP 1 2 3 5 4

                    PSC 1 2 3 5 4

                    C’S 1 5 4 3 2

                    UDC 1 2 4 5 3
                """
            }
            { type: "basic", topic: "modelTerritorial", answerResemblanceToPartyMatrix:
                """
                    JxS 1 2 3 4 5

                    CSQEP 2 4 5 3 1

                    CUP 1 2 3 4 5

                    PP 5 4 3 2 1

                    PSC 5 4 3 2 1

                    C’S 5 4 3 2 1

                    UDC 4 5 3 2 1
                """
            }
            { type: "basic", topic: "modelTerritorial", answerResemblanceToPartyMatrix:
                """
                    JxS 5 4 3 2 1

                    CSQEP 4 5 3 2 1

                    CUP 5 4 3 2 1

                    PP 1 2 3 4 5

                    PSC 1 5 4 3 2

                    C’S 1 2 3 5 4

                    UDC 3 5 4 2 1
                """
            }
            { type: "basic", topic: "modelTerritorial", answerResemblanceToPartyMatrix:
                """
                    JxS 1 2 3 4 5

                    CSQEP 1 2 3 4 5

                    CUP 1 2 3 4 5

                    PP 5 4 3 2 1

                    PSC 1 2 3 4 5

                    C’S 5 4 3 2 1

                    UDC 1 2 3 4 5
                """
            }
            { type: "basic", topic: "modelTerritorial", answerResemblanceToPartyMatrix:
                """
                    JxS 5 4 3 2 1

                    CSQEP 4 3 5 2 1

                    CUP 2 4 5 3 1

                    PP 1 2 3 4 5

                    PSC 4 5 3 2 1

                    C’S 1 2 3 4 5

                    UDC 5 4 3 2 1
                """
            }
            { type: "basic", topic: "modelTerritorial", answerResemblanceToPartyMatrix:
                """
                    JxS 1 2 3 4 5

                    CSQEP 1 2 3 5 4

                    CUP 1 2 3 4 5

                    PP 5 4 3 2 1

                    PSC 1 2 3 4 5

                    C’S 5 4 3 2 1

                    UDC 1 2 3 4 5
                """
            }
            { type: "basic", topic: "estatDelBenestar", answerResemblanceToPartyMatrix:
                """
                    JxS 4 5 3 2 1

                    CSQEP 5 4 3 2 1

                    CUP 5 4 3 2 1

                    PP 2 3 4 5 1

                    PSC 4 5 3 2 1

                    C’S 1 3 5 4 2

                    UDC 4 5 3 2 1
                """
            }
            { type: "basic", topic: "estatDelBenestar", answerResemblanceToPartyMatrix:
                """
                    JxS 2 4 5 3 1

                    CSQEP 5 4 3 2 1

                    CUP 5 4 3 2 1

                    PP 1 2 3 4 5

                    PSC 2 5 3 4 1

                    C’S 2 5 4 3 1

                    UDC 1 2 3 5 4
                """
            }
            { type: "basic", topic: "estatDelBenestar", answerResemblanceToPartyMatrix:
                """
                    JxS 2 4 5 3 1

                    CSQEP 5 4 3 2 1

                    CUP 5 4 3 2 1

                    PP 1 2 3 4 5

                    PSC 3 5 4 2 1

                    C’S 1 2 3 5 4

                    UDC 3 4 5 2 1
                """
            }
            { type: "basic", topic: "estatDelBenestar", answerResemblanceToPartyMatrix:
                """
                    JxS 1 2 5 4 3

                    CSQEP 1 2 3 4 5

                    CUP 1 2 3 4 5

                    PP 5 4 3 2 1

                    PSC 1 2 3 5 4

                    C’S 1 2 4 5 3

                    UDC 1 3 4 5 2
                """
            }
            { type: "basic", topic: "ciutadania", answerResemblanceToPartyMatrix:
                """
                    JxS 4 5 3 2 1

                    CSQEP 5 4 3 2 1

                    CUP 5 4 3 2 1

                    PP 1 2 3 5 4

                    PSC 4 5 3 2 1

                    C’S 4 5 3 2 1

                    UDC 1 2 3 5 4
                """
            }
            { type: "basic", topic: "ciutadania", answerResemblanceToPartyMatrix:
                """
                    JxS 4 5 3 2 1

                    CSQEP 5 4 3 2 1

                    CUP 5 4 3 2 1

                    PP 1 2 3 5 4

                    PSC 4 5 3 2 1

                    C’S 5 4 3 2 1

                    UDC 1 2 3 5 4
                """
            }
            { type: "basic", topic: "ciutadania", answerResemblanceToPartyMatrix:
                """
                    JxS 1 2 3 4 5

                    CSQEP 1 2 3 4 5

                    CUP 1 2 3 4 5

                    PP 5 4 3 2 1

                    PSC 1 2 3 4 5

                    C’S 1 2 3 5 4

                    UDC 5 4 3 2 1
                """
            }
            { type: "basic", topic: "ciutadania", answerResemblanceToPartyMatrix:
                """
                    JxS 5 4 3 2 1

                    CSQEP 5 4 3 2 1

                    CUP 5 4 3 2 1

                    PP 1 2 3 4 5

                    PSC 4 5 3 2 1

                    C’S 2 4 5 3 1

                    UDC 3 5 4 2 1
                """
            }
            { type: "basic", topic: "ciutadania", answerResemblanceToPartyMatrix:
                """
                    JxS 5 4 3 2 1

                    CSQEP 5 4 3 2 1

                    CUP 5 4 3 2 1

                    PP 1 2 3 4 5

                    PSC 4 5 3 2 1

                    C’S 2 4 5 3 1

                    UDC 3 5 4 2 1
                """
            }
            { type: "basic", topic: "ciutadania", answerResemblanceToPartyMatrix:
                                                  """
                    JxS 5 4 3 2 1

                    CSQEP 5 4 3 2 1

                    CUP 5 4 3 2 1

                    PP 1 2 3 4 5

                    PSC 4 5 3 2 1

                    C’S 2 4 5 3 1

                    UDC 3 5 4 2 1
                """
            }
            { type: "basic", topic: "territoriEcologiaIMediAmbient", answerResemblanceToPartyMatrix:
                """
                    JxS 1 2 3 5 4

                    CSQEP 1 2 3 4 5

                    CUP 1 2 3 4 5

                    PP 3 5 4 2 1

                    PSC 1 2 4 5 3

                    C’S 1 2 3 4 5

                    UDC 1 2 4 5 3
                """
            }
            { type: "basic", topic: "territoriEcologiaIMediAmbient", answerResemblanceToPartyMatrix:
                """
                    JxS 1 2 3 5 4

                    CSQEP 1 2 3 4 5

                    CUP 1 2 3 4 5

                    PP 2 3 4 5 1

                    PSC 1 2 3 4 5

                    C’S 1 2 3 4 5

                    UDC 1 2 3 5 4
                """
            }
            { type: "basic", topic: "territoriEcologiaIMediAmbient", answerResemblanceToPartyMatrix:
                """
                    JxS 1 3 4 5 2

                    CSQEP 1 2 3 4 5

                    CUP 1 2 3 4 5

                    PP 5 4 3 2 1

                    PSC 1 2 3 4 5

                    C’S 1 2 4 5 3

                    UDC 1 2 5 4 3
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
            { id: "age", mandatory: true, type: "button", order: 1, options: [
                "age0"
                "age1"
                "age2"
                "age3"
                "age4"
                "age5"
                "age6"
                ]
            }
            { id: "genre", mandatory: true, type: "button", order: 2, options:  [
                "male"
                "female"
                "intersexual"
                ]
            }
            { id: "postalCode", mandatory: true, type: "input", order: 3, validate: "^([1-9]{2}|[0-9][1-9]|[1-9][0-9])[0-9]{3}$", errorMessageId: "incorrectPostalCode" }

            { id: "educationLevel", mandatory: false, type: "button", order: 4, options:  [
                "noStudies"
                "primaryStudies"
                "secondaryStudies"
                "professionalFormation"
                "superiorStudies"
                "postgraduateStudies"
                ]
            }
            { id: "cotidianLanguage", mandatory: false, type: "button", order: 5, options:  [
                "catalan"
                "spanish"
                "bothLanguages"
                ]
            }
            { id: "votingRecord", mandatory: false, type: "button", order: 6, options: [
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
            { id: "votingIntention", mandatory: false, type: "button", order: 7, options: [
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
            unless PersonalQuestions.findOne({ id: question.id })?
                PersonalQuestions.insert(question, (err, res) ->
                    console.error(err) if err
                )


    Meteor.startup( ->
        createTopics()
        createPoliticalParties()
        createPoliticalQuestions()
        createPersonalQuestions()
    )

