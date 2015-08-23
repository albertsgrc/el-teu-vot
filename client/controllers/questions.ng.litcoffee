# Questions angular controller

    QuestionsCtrl = ($scope, $state, $rootScope) ->
        $scope.nAnsweredPolitical = 0

        $scope.politicalQuestions = [
            {
                type: "Economia i Estat del Benestar"
                text: "La adopción del euro fue positiva para España"
                answerType: 2
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
            {
                type: "Economia"
                text: "La adopción del euro fue positiva para España"
                answerType: 1
                answer: null
            }
        ]

        $scope.personalQuestions =
            mandatory: [
                {
                    id: "age"
                    answerType: "buttons"
                    answers: [
                        "age0"
                        "age1"
                        "age2"
                        "age3"
                        "age4"
                        "age5"
                        "age6"
                    ]
                    answer: null
                }
                {
                    id: "genre"
                    answerType: "buttons"
                    answers: [
                        "male"
                        "female"
                        "intersexual"
                    ]
                    answer: null
                }
                {
                    id: "postalCode"
                    answerType: "input"
                    validate: /^([1-9]{2}|[0-9][1-9]|[1-9][0-9])[0-9]{3}$/
                    errorMessage: "incorrectPostalCode"
                    blurred: false
                    valid: false
                    answer: null
                }
            ]

            optional: [
                {
                    id: "educationLevel"
                    answerType: "buttons"
                    answers: [
                        "noStudies"
                        "primaryStudies"
                        "secondaryStudies"
                        "professionalFormation"
                        "superiorStudies"
                        "postgraduateStudies"
                    ]
                    answer: null
                }
                {
                    id: "cotidianLanguage"
                    answerType: "buttons"
                    answers: [
                        "catalan"
                        "spanish"
                        "bothLanguages"
                    ]
                    answer: null
                }
                {
                    id: "votingRecord"
                    answerType: "buttons"
                    answers: [
                        "ciu"
                        "cs"
                        "cup"
                        "erc"
                        "icv-euia"
                        "ppc"
                        "psc"
                        "otherVotingRecord"
                        "white"
                        "null"
                        "abstention"
                        "doesntKnowDoesntAnswer"
                    ]
                    answer: null
                }
                {
                    id: "votingIntention"
                    answerType: "buttons"
                    answers: [
                        "cs"
                        "catalunyaSiQueEsPot"
                        "cup"
                        "juntsPelSi"
                        "ppc"
                        "psc"
                        "udc"
                        "otherVotingRecord"
                        "white"
                        "null"
                        "abstention"
                        "doesntKnowDoesntAnswer"

                    ]
                    answer: null
                }
            ]

        $scope.setAnswer = (type, question, answer) ->
            switch type
                when "political"
                    ++$scope.nAnsweredPolitical if question.answer is null and answer isnt null

            question.answer = answer

        $scope.allAnswered = (type) ->
            switch type
                when "political" then $scope.nAnsweredPolitical is $scope.politicalQuestions.length
                when "personal"
                    _.every($scope.personalQuestions.mandatory,
                        (question) ->
                            if question.answerType is "input"
                                return question.valid
                            else return question.answer isnt null
                    )

        $scope.goToPersonalQuestions = ->
            if $scope.allAnswered("political")
                $state.go('personalQuestions')
            else
                $rootScope.goToQuestion((->return parseInt(i) + 1 for i, x of $scope.politicalQuestions when x.answer is null)(), -> setTimeout((-> $(".etv-alert").modal("show")), 100))

            return true

        $scope.goToResults = ->
            if $scope.allAnswered("personal")
                $state.go('results')
            else
                $('html, body').animate({ scrollTop: $(".personalMandatoryQuestionsContainer").offset().top - $("header").outerHeight(true)}, 400, ( -> setTimeout(( -> $(".etv-alert").modal("show") ), 100) ))

            return true

        $scope.setBlurred = (question) -> question.blurred = true

    app.controller('QuestionsCtrl', ['$scope', '$state', '$rootScope', QuestionsCtrl])