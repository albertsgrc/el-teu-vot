# Questions service

    questionsService = ($meteor, $q) ->
        politicalQuestions = []

        (@reset = ->
            politicalQuestions = [
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

            for pq in politicalQuestions when pq.type is "basic"
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

            politicalQuestion.number = i + 1 for politicalQuestion, i in politicalQuestions
        )()

        pendingPoliticalRequests = []

        getPoliticalQuestionsError = false

        resolvePendingRequests = (obj, hasErr) ->
            if hasErr
                for pendingRequest in pendingPoliticalRequests
                    pendingRequest.reject(obj)
            else
                for pendingRequest in pendingPoliticalRequests
                    pendingRequest.resolve(obj)

            pendingRequests = []

        @getPoliticalQuestions = ->
            q = $q.defer()

            if politicalQuestions?
                q.resolve(politicalQuestions)
            else
                pendingPoliticalRequests.push q

            return q.promise

        @



    app.service('questionsService', ['$meteor', '$q', questionsService])