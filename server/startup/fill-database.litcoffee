# Fills the database with the data if currently empty

    self = @

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


    createAdminUser = ->
        unless Meteor.users.findOne({ username: 'admin' })?
            Accounts.createUser(
                username: 'admin'
                password: 'ElTeuVot2015+9377'
            )

    createTranslations = ->
        TRANSLATIONS = [
            {
                _id: "elTeuVot"
                type: "pageNames"
                translations: [
                    {
                        lang: "ca"
                        value: "El teu vot"
                    }
                    {
                        lang: "es"
                        value: "El teu vot"
                    }
                ]
            }
            {
                _id: "howItsDone"
                type: "pageNames"
                translations: [
                    {
                        lang: "ca"
                        value: "Com ho hem fet"
                    }
                    {
                        lang: "es"
                        value: "Cómo está hecho"
                    }
                ]
            }
            {
                _id: "whoWeAre"
                type: "pageNames"
                translations: [
                    {
                        lang: "ca"
                        value: "Qui som"
                    }
                    {
                        lang: "es"
                        value: "Quienes somos"
                    }
                ]
            }
            {
                _id: "welcomeText"
                type: "elTeuVot"
                translations: [
                    {
                        lang: "ca"
                        value: "Descobreix la teva posició dins del mapa polític català<br/>i decideix quin serà El teu Vot"
                    }
                    {
                        lang: "es"
                        value: "Descubre tu posición dentro del mapa político catalán<br/>y decide cual será tu voto"
                    }
                ]
            }
            {
                _id: "countText"
                type: "elTeuVot"
                translations: [
                    {
                        lang: "ca"
                        value: "qüestionaris resolts fins ara. I tu, a què esperes?"
                    }
                    {
                        lang: "es"
                        value: "cuestionarios resueltos hasta ahora. Y tú, a qué esperas?"
                    }
                ]
            }
            {
                _id: "welcomeStart"
                type: "elTeuVot"
                translations: [
                    {
                        lang: "ca"
                        value: "Comença"
                    }
                    {
                        lang: "es"
                        value: "Empezar"
                    }
                ]
            }
            {
                _id: "soonText"
                type: "elTeuVot"
                translations: [
                    {
                        lang: "ca"
                        value: "Pròximament"
                    }
                    {
                        lang: "es"
                        value: "Próximamente"
                    }
                ]
            }
            {
                _id: "whoWeAreMainText"
                type: "whoWeAre"
                translations: [
                    {
                        lang: "ca"
                        value: "El teu Vot és una Aplicació d’Orientació del Vot (Voting Advice Application) d’àmbit català, creat en el marc de les eleccions al Parlament de Catalunya del 27 de setembre de 2015. Les Aplicacions d’Orientació del Vot (AOV) són eines electròniques que permeten ubicar a l’elector dins d’un sistema de partits determinat. Aquest tipus d’aplicació no busca determinar el vot de l’elector sinó oferir un posicionament concret segons les seves respostes de manera precisa i d’acord amb les propostes i accions de les diferents candidatures.<br/><br/> El teu Vot, amb forma de pàgina web, es basa en un qüestionari que ubica l’usuari o usuària ideològicament en blocs temàtics concrets respecte a les candidatures que concorren a les eleccions del 27 de setembre de 2015 al Parlament de Catalunya. Un cop el completi, l’usuari obtindrà una sèrie de resultats que li permetran veure de manera gràfica i intuïtiva quina és la candidatura que més s’apropa a les seves preferències. El teu Vot és una iniciativa que es construeix des del rigor metodològic i la total independència respecte partits i institucions públiques, dos trets distintius essencials per tal de garantir uns resultats fidedignes als nostres usuaris.<br/><br/> El teu Vot és un projecte que neix de la col·laboració entre <strong>El teu Parlament</strong> i <strong>apps4citizens</strong>. Aquesta aliança ha permès treballar des de l’experiència de l’equip d’apps4citizens al mateix temps que comptàvem amb el bagatge en la creació de plataformes d’eines digitals d’El teu Parlament."
                    }
                    {
                        lang: "es"
                        value: "El teu Vot es una Aplicación de Orientación de Voto (Voting Advice Application) de ámbito catalán, creada en el marco de las elecciones al Parlament de Cataluña del 27 de Septiembre de 2015. Las Aplicaciones de Orientación de Voto (AOV) son herramientas electrónicas que permiten ubicar al elector dentro de un sistema de partidos concreto. Este tipo de aplicaciones no buscan determinar el voto, sino ofrecer un posicionamiento concreto según las respuestas, de forma precisa y de acuerdo con las propuestas y acciones de las diferentes candidaturas.<br/><br/> El teu Vot, que toma la forma de página web, se basa en un cuestionario que ubica al usuario o usuaria ideológicamente en bloques temáticos concretos respecto a las candidaturas que participan en las elecciones del 27 de septiembre de 2015 al Parlament de Catalunya. Una vez completado el cuestionario, el usuario obtendrá una serie de resultados que le permitirán ver de manera gráfica e intuitiva cuál es la candidatura que más se aproxima a sus preferencias. El teu Vot es una iniciativa que se construye des del rigor metodológico y la total independencia respecto a los partidos e instituciones públicas, dos peculiaridades distintivas esenciales para poder garantizar unos resultados veraces para nuestros usuarios.<br/><br/> El teu Vot es un proyecto que nace de la colaboración entre <strong>El Teu Parlament</strong> y <strong>apps4citizens</strong>. Esta alianza ha permitido unir la experiencia del equipo de apps4citizens y el bagaje en la creación de herramientas digitales de El teu Parlament."
                    }
                ]
            }
            {
                _id: "whoWeAreEtpText"
                type: "whoWeAre"
                translations: [
                    {
                        lang: "ca"
                        value: "El Teu Parlament és una organització de monitoratge parlamentari (OMP) impulsada per quatre politòlegs de la Universitat Pompeu Fabra. Com a OMP, El teu Parlament és una organització independent i sense ànim de lucre que té per objectiu la millora de la transparència de la institució que monitoritza; el Parlament de Catalunya. Mitjançant la creació d’eines electròniques, El teu Parlament vol promoure la cultura de la transparència per tal d’aconseguir un debat públic més profund i de major qualitat, que ajudi a millorar la cultura política ciutadana a la recerca d’un sistema democràtic de més qualitat."
                    }
                    {
                        lang: "es"
                        value: "El teu Parlament es una Organización de Monitoreo Parlamentario (OMP) de ámbito catalán, impulsada por cuatro politólogos de la Universidad Pompeu Fabra. Como OMP, El teu Parlament es una organización independiente y sin ánimo de lucro, que tiene como objetivo la mejora de la transparencia  de la institución que monitorea, el Parlament de Cataluña. Mediante la creación de una herramienta electrónica, El teu Parlament pretende promover la cultura de la transparencia para conseguir un debate público más profundo y de mejor calidad, que ayude a mejorar la cultura política ciudadana, con el objetivo de mejorar la calidad de nuestro sistema democrático."
                    }
                ]
            }
            {
                _id: "whoWeAreapps4citizensText"
                type: "whoWeAre"
                translations: [
                    {
                        lang: "ca"
                        value: "apps4citizens és una plataforma que té com a objectiu principal promoure, per una banda, l’ús d’aplicacions mòbils com un instrument útil per a millorar la qualitat democràtica dels processos de presa de decisions a través del compromís social i polític, i de l’apoderament dels propis ciutadans; i, per l’altra, acompanyar les organitzacions en la implementació de models de desenvolupament tecnològic diferents, sustentats en la intel·ligència i el talent compartits (crowd) i basats en la innovació i el compromís social dels agents que intervenen."
                    }
                    {
                        lang: "es"
                        value: "apps4citizens es una plataforma que tiene como objetivo promover por un lado el uso de aplicaciones móviles como instrumento útil para mejorar la calidad democrática de los procesos de toma de decisiones a través del compromiso social y político, el apoderamiento de los propios ciudadanos, y por otro lado, acompañar a diferentes organizaciones en la implementación de modelos de desarrollo tecnológico, sustentados en la inteligencia y el talento compartidos (crowd) y basados en la innovación y el compromiso social de los agentes que intervienen."
                    }
                ]
            }
            {
                _id: "howItsDoneTitle"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "Com ho hem fet"
                    }
                    {
                        lang: "es"
                        value: "¿Cómo lo hemos hecho?"
                    }
                ]
            }
            {
                _id: "howItsDoneMainText"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "El projecte d’<i>El teu Vot</i> es construeix sobre dos pilars fonamentals:<br/><strong>la metodologia</strong>, és a dir, la manera com s’ha creat aquesta <b>aplicació d’orientació del vot</b>;<br/> i <strong>la independència</strong> respecte a partits polítics i/o institucions públiques.<br/><br/> Aquests dos elements doten aquesta iniciativa del rigor i la validesa necessàries per a ser tingut en compte a l’hora d’ubicar l’elector en l’escenari polític català previ a les eleccions del 27 de setembre de 2015 al Parlament de Catalunya.<br/><br/> La metodologia és molt important a l’hora d’elaborar un projecte de les característiques d’<strong><i>El teu Vot<i/></strong>. És molt important que l’usuari pugui saber d’on surten els seus resultats. Però no només això, és també important saber per què les preguntes que conformen el qüestionari són les adequades, per què les opcions de resposta són unes i no unes altres, com es defineixen les preferències dels partits i, per descomptat, com les respostes de cada elector es tradueixen en números i aquests en gràfics."
                    }
                    {
                        lang: "es"
                        value: "El proyecto de <i>El teu Vot</i> se construye sobre dos pilares fundamentales:<br/>la <strong>metodología</strong>, esto es, el modo como se ha creado esta <strong>aplicación de orientación del voto</strong>;<br/>y la <strong>independencia</strong> respecto a partidos políticos e instituciones públicas.<br/><br/> Estos dos elementos dotan a esta iniciativa del rigor y la validez necesarias para ser tenida en cuenta a la hora de ubicar el electorado en el escenario político catalán previo a las elecciones del 27 de septiembre de 2015 al Parlament de Catalunya.<br/><br/> La metodología es muy importante a la hora de elaborar un proyecto con las características de <strong><i>El teu Vot</i></strong> –el usuario debe poder saber de dónde salen sus resultados. Pero no solo esto: también es importante saber por qué las preguntas que conforman el cuestionario son las más adecuadas, por qué las opciones de respuesta son unas y no otras, cómo se definen las preferencias de los partidos y, por supuesto, cómo las respuestas de cada elector se traducen en números y éstos en gráficos."
                    }
                ]
            }
            {
                _id: "howItsDoneExplanationMainTitle"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "De les preguntes als gràfics"
                    }
                    {
                        lang: "es"
                        value: "De las preguntas a los gráficos"
                    }
                ]
            }
            {
                _id: "howItsDoneExplanationTitle1"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "Elaboració del qüestionari"
                    }
                    {
                        lang: "es"
                        value: "Elaboración del cuestionario"
                    }
                ]
            }
            {
                _id: "howItsDoneExplanationText1"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "El qüestionari d’<i>El teu Vot</i> consta de 23 preguntes, l’elaboració de les quals ha seguit els criteris següents:<br/><br/> a. <strong>Actualitat</strong> dels temes en l’àmbit polític català<br/> b. Qüestions que siguin <strong>competència de la Generalitat de Catalunya</strong><br/> c. Possibilitat de <strong>matisar</strong> la resposta (hem evitat respostes dicotòmiques) per tal de ser més precisos a l’hora de definir les preferències tant dels partits com dels usuaris<br/> d. Possibilitat de <strong>contrastar</strong> les respostes amb informació ja existent sobre els posicionaments del partit, i<br/> e. <strong>Neutralitat</strong> en la formulació de les preguntes<br/>"
                    }
                    {
                        lang: "es"
                        value: "El cuestionario de <i>El teu Vot</i> consta de 23 preguntas, cuya elaboración ha seguido los criterios siguientes:<br/><br/> a. <strong>Actualidad</strong> de los temas en el ámbito político catalán<br/> b. Materias que sean <strong>competencia de la Generalitat de Cataluña</strong><br/> c. Posibilidad de <strong>matizar</strong> la respuesta (hemos evitado respuestas dicotómicas) para poder ser más precisos a la hora de definir las preferencias tanto de los partidos como de los usuarios<br/> d. Posibilidad de <strong>contrastar</strong> las respuestas con información ya existente sobre el posicionamiento del partido<br/> e. <strong>Neutralidad</strong> en la formulación de las preguntas<br/>"
                    }
                ]
            }
            {
                _id: "howItsDoneExplanationTitle2"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "Elecció de les respostes"
                    }
                    {
                        lang: "es"
                        value: "Elección de las respuestas"
                    }
                ]
            }
            {
                _id: "howItsDoneExplanationSubtitle21"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "Respostes del qüestionari"
                    }
                    {
                        lang: "es"
                        value: "Respuestas del cuestionario"
                    }
                ]
            }
            {
                _id: "howItsDoneExplanationText211"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "Totes les preguntes del qüestionari tindran la mateixa escala de respostes. Aquesta escala constarà de <strong>cinc categories</strong> etiquetades i elegides d’acord a criteris acadèmics. Considerem que amb cinc categories de resposta es pot observar la direcció i la intensitat de la resposta, alhora que permet també una categoria neutral. Les categories seran:"
                    }
                    {
                        lang: "es"
                        value: "Todas las preguntas del cuestionario tienen la misma escala de respuestas. Esta escala consta de <strong>cinco categorías</strong> etiquetadas y elegidas de acuerdo con criterios académicos. Consideramos que con cinco categorías de respuesta se puede observar la dirección y la intensidad de la respuesta, a la vez que permite también una categoría neutral. Las categorías son:"
                    }
                ]
            }
            {
                _id: "howItsDoneExplanationText212"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "També s’inclourà una opció de No sap/No contesta, perquè s’obliga a respondre totes les preguntes i és necessària una opció on l’enquestat pugui recórrer en cas de no saber la resposta o no voler respondre (però tot i així, acabar el qüestionari).<br/> Aquestes categories de resposta seran les de les preguntes que conformen el qüestionari. Així mateix, com s’ha explicat, també hi haurà <strong>preguntes per conèixer les característiques dels usuaris</strong>. Aquestes tindran opcions de resposta diverses: intervals d’edat, sexe, llengua parlada habitualment, nivell d’estudis i codi postal."
                    }
                    {
                        lang: "es"
                        value: "También se incluye una opción de No sabe/No contesta: dado que se obliga a responder todas las preguntas, es necesaria una opción a la que el encuestado pueda recurrir en caso de no saber la respuesta o no querer responder –y, aún con ello, quiera acabar el cuestionario.<br/> Estas categorías de respuesta son las de las preguntas que conforman el cuestionario principal. Asimismo, también hay <strong>preguntas para conocer las características de los usuarios</strong>. Éstas tienen varias opciones de respuesta: intervalos de edad, género, lengua hablada habitualmente, nivel de estudios y código postal."
                    }
                ]
            }
            {
                _id: "howItsDoneExplanationSubtitle22"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "Preferències de les candidatures"
                    }
                    {
                        lang: "es"
                        value: "Preferencias de las candidaturas"
                    }
                ]
            }
            {
                _id: "howItsDoneExplanationText22"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "L’objectiu del qüestionari és determinar la proximitat dels enquestats amb unes candidatures o d’altres. És per això que, d’una banda, és necessari saber les preferències dels electors i, per l’altra, saber les preferències de les candidatures.<br/><br/> Cada llista presentada a les eleccions se li atorgaran unes preferències d’acord a quatre elements:"
                    }
                    {
                        lang: "es"
                        value: "El objetivo del cuestionario es determinar la proximidad de los encuestados con unas candidaturas u otras. Es por ello que, por un lado, es necesario saber las preferencias de los electores y, por el otro, las de las candidaturas.<br/><br/> A cada lista que se presente a las elecciones se le atorgan unas preferencias de acuerdo con cuatro elementos:"
                    }
                ]
            }
            {
                _id: "howItsDoneExplanationSubtitle221"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "Decisió de cada candidatura"
                    }
                    {
                        lang: "es"
                        value: "Decisión de cada candidatura"
                    }
                ]
            }
            {
                _id: "howItsDoneExplanationText221"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "El qüestionari definitiu serà enviat al les candidatures que concorren a les eleccions. Les respostes que elegeixin per cada pregunta seran tingudes en compte a l’hora de definir les seves preferències. No obstant, això pot comportar que els partits recorrin a la resposta més “positiva” o encarada a guanyar vots, és per això que també es tindran en compte tres elements més."
                    }
                    {
                        lang: "es"
                        value: "El cuestionario definitivo es enviado a las candidaturas que concurren a las elecciones. Las respuestas que elijan para cada pregunta serán consideradas a la hora de definirsus preferencias. No obstante, ello puede comportar que los partidos recurran a la respuesta más \"positiva\" o encarada a ganar votos, por lo que también se tienen en cuenta tres elementos más."
                    }
                ]
            }
            {
                _id: "howItsDoneExplanationSubtitle222"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "Activitat parlamentària"
                    }
                    {
                        lang: "es"
                        value: "Actividad parlamentaria"
                    }
                ]
            }
            {
                _id: "howItsDoneExplanationText222"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "L’equip d’El teu Vot farà un repàs a l’acció parlamentària de cada candidatura en seu parlamentària per ubicar les seves preferències d’acord a la tasca realitzada. No obstant, aquestes eleccions presenten canvis evidents (principalment, perquè hi concorren candidatures de confluència entre diferents formacions), és per això que l’activitat parlamentària feta a la darrera legislatura pot no ser del tot fidedigne amb les preferències que mostrin les llistes de cara a les eleccions que ens ocupen. És per això que es també es definiran les preferències segons dos elements més."
                    }
                    {
                        lang: "es"
                        value: "El cuestionario definitivo es enviado a las candidaturas que concurren a las elecciones. Las respuestas que elijan para cada pregunta serán consideradas a la hora de definir sus preferencias. No obstante, ello puedo comportar que los partidos recurran a la respuesta más “positiva” o encarada a ganar votos, por lo que también se tienen en cuenta tres elementos más."
                    }
                ]
            }
            {
                _id: "howItsDoneExplanationSubtitle223"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "Hemeroteca"
                    }
                    {
                        lang: "es"
                        value: "Hemeroteca"
                    }
                ]
            }
            {
                _id: "howItsDoneExplanationText223"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "Les preferències dels partits solen quedar reflectides als diferents mitjans de comunicació. És per això que també es farà un repàs de les declaracions fetes pels diferents membres dels partits que apareixen als diferents mitjans."
                    }
                    {
                        lang: "es"
                        value: "Las preferencias de los partidos suelen quedas reflejadas en los diferentes medios de comunicación. Es por ello que también se hace una revisión de las declaraciones hechas por los diversos representantes de partidos y candidaturas que aparecen en los medios."
                    }
                ]
            }
            {
                _id: "howItsDoneExplanationSubtitle224"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "Programes electorals"
                    }
                    {
                        lang: "es"
                        value: "Programas electorales"
                    }
                ]
            }
            {
                _id: "howItsDoneExplanationText224"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "Finalment, no es poden entendre les preferències dels partits sense tenir en compte els programes electorals amb que els partits es presenten a les eleccions. És per això que per definir les preferències dels partits es farà un repàs exhaustiu dels programes electorals, on presenten per escrit les propostes que duran a terme en cas de guanyar les eleccions."
                    }
                    {
                        lang: "es"
                        value: "Por último (pero no menos importante), no se pueden entender las preferencias de los partidos sin considerar los programas electorales con que los partidos se presentan a las elecciones. Es por ello que también se hace una revisión exhaustiva de los programas electorales, en que se presentan por escrito las propuestas que las candidaturas se comprometen a llevar a cabo en caso de ganar las elecciones."
                    }
                ]
            }
            {
                _id: "howItsDoneExplanationText231"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "Combinant aquests quatre elements, s’establiran les preferències de cada llista en una matriu de dades. A tall d’exemple:"
                    }
                    {
                        lang: "es"
                        value: "Combinando estos cuatro elementos, se establecerán las preferencias de cada lista en una matriz de datos. Como ejemplo:"
                    }
                ]
            }
            {
                _id: "howItsDoneExplanationText232"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "Segons aquesta taula, per la candidatura Y la resposta més propera a les seves preferències a la Pregunta X és Totalment d’acord (TDA = 5). De la mateixa manera, la resposta més llunyana a les seves preferències és Totalment en desacord (TED = 0). Per tant, si un enquestat respon a la pregunta X que hi està totalment d’acord, aquesta resposta aproparà les seves preferències a les del partit Y. Aquesta taula estarà feta per cada totes les preguntes del qüestionari i tots els partits que es presenten a les eleccions. El segon tipus de pregunta es basa en l’autoubicació dins de dos escales del 0 al 10. En primer lloc ens trobarem en l’autoubicació en l’eix ideològic, sent 0 extrema esquerra i 10 extrema dreta. El segon eix és el de la preferència territorial o nacional, on 0 equival a preferència per un Estat Espanyol centralitzat i el 10 equival a un estat propi per Catalunya. Per últim, la darrera pregunta demanarà a l’enquestat que ordeni els diferents blocs temàtics segons la importància subjectiva que els hi doni. Es farà el mateix amb les diferents candidatures. Aquesta darrera pregunta ponderarà els diferents blocs segons la importància que l’usuari els doni (veure <a target='_blank' href='/documents/operacionalitzacio_resultats.pdf'><u>operacionalització</u></a> dels resultats) i permetrà definir millor la proximitat entre partit i elector."
                    }
                    {
                        lang: "es"
                        value: "Según esta matriz, para la Candidatura Y la respuesta más próxima a sus preferencias en lo que a la Pregunta X respecta es Totalmente De Acuerdo (TDA = 5). Por el contrario, la respuesta más alejada de sus preferencias es Totalmente En Desacuerdo (TED = 0). Por lo tanto, si un encuestado responde a la Pregunta X que está Totalmente De Acuerdo, esta respuesta acercará sus preferencias a las de la Candidatura Y. Ésta tabla se reproduce para todas las preguntas del cuestionario e incluye a todas las candidaturas que se presentan a las elecciones.<br/><br/> El segundo tipo de pregunta se basa en la autoubicación dentro de dos escalas que van del 0 al 10. La primera es una autoubicación en el eje ideológico, siendo 0 igual a “Extrema Izquierda” y 10, “Extrema Derecha”. El segundo eje es el de preferencia por el modelo territorial o nacional, donde 0 equivale a preferencia por un Estado Español centralizado y el 10, a un Estado propio para Cataluña.<br/><br/> Finalmente, la última pregunta pide al encuestado que ordene los diferentes bloques temáticos según la importancia subjetiva que les atorgue. Dado que habremos definido este orden de preferencias para cada candidatura, esta pregunta nos permitirá ponderar los diferentes bloques según su importancia subjetiva a la hora de decidir el voto (ver <a target='_blank' href='/documents/operacionalizacion_resultados.pdf'><u>operacionalización</u></a> de los resultados) y permitirá definir mejor la proximidad entre candidatura y elector."
                    }
                ]
            }
            {
                _id: "questionTableLabel"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "Pregunta X"
                    }
                    {
                        lang: "es"
                        value: "Pregunta X"
                    }
                ]
            }
            {
                _id: "candidacyTableLabel"
                type: "howItsDone"
                translations: [
                    {
                        lang: "ca"
                        value: "Candidatura Y"
                    }
                    {
                        lang: "es"
                        value: "Candidatura Y"
                    }
                ]
            }
            {
                _id: "politicalQuestionsError"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Ho sentim, s'ha produït un error durant la càrrega del qüestionari. Torni-ho a intentar."
                    }
                    {
                        lang: "es"
                        value: "Lo sentimos, se ha producido un error durante la carga del cuestionario. Vuelva a intentarlo."
                    }
                ]
            }
            {
                _id: "politicalQuestionsLoading"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "S'està carregant el qüestionari, només serà un moment..."
                    }
                    {
                        lang: "es"
                        value: "Se está cargando el cuestionario, solo será un momento..."
                    }
                ]
            }
            {
                _id: "endTest"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Finalitza el test"
                    }
                    {
                        lang: "es"
                        value: "Finaliza el test"
                    }
                ]
            }
            {
                _id: "ted"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Completament en desacord"
                    }
                    {
                        lang: "es"
                        value: "Totalmente en desacuerdo"
                    }
                ]
            }
            {
                _id: "ed"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "En desacord"
                    }
                    {
                        lang: "es"
                        value: "En desacuerdo"
                    }
                ]
            }
            {
                _id: "nand"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Ni d'acord ni en desacord"
                    }
                    {
                        lang: "es"
                        value: "Ni de acuerdo ni en desacuerdo"
                    }
                ]
            }
            {
                _id: "da"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "D'acord"
                    }
                    {
                        lang: "es"
                        value: "De acuerdo"
                    }
                ]
            }
            {
                _id: "tda"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Completament d'acord"
                    }
                    {
                        lang: "es"
                        value: "Totalmente de acuerdo"
                    }
                ]
            }
            {
                _id: "nsnc"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "No sap/No contesta"
                    }
                    {
                        lang: "es"
                        value: "No sabe/No contesta"
                    }
                ]
            }
            {
                _id: "politicalQuestionsAlert"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Abans de poder accedir al següent apartat, cal que responguis totes les preguntes del qüestionari!"
                    }
                    {
                        lang: "es"
                        value: "Antes de poder acceder al siguiente apartado, es necesario que respondas todas las preguntas del cuestionario!"
                    }
                ]
            }
            {
                _id: "extremeLeft"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Extrema esquerra"
                    }
                    {
                        lang: "es"
                        value: "Extrema izquierda"
                    }
                ]
            }
            {
                _id: "extremeRight"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Extrema dreta"
                    }
                    {
                        lang: "es"
                        value: "Extrema derecha"
                    }
                ]
            }
            {
                _id: "centralizedState"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Estat centralitzat"
                    }
                    {
                        lang: "es"
                        value: "Estado centralizado"
                    }
                ]
            }
            {
                _id: "ownState"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Estat propi"
                    }
                    {
                        lang: "es"
                        value: "Estado propio"
                    }
                ]
            }
            {
                _id: "sortTip"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "(Clica sobre cada botó i arrossega'l cap a la posició que prefereixis. Si no vols canviar l'ordre, només clica sobre l'opció)"
                    }
                    {
                        lang: "es"
                        value: "(Haz clic encima de cada botón y arrástralo hasta la posición que prefieras. Si no quieres cambiar el orden, sólo pulsa encima de la opción)"
                    }
                ]
            }
            {
                _id: "question1"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "L’elecció dels candidats de les llistes electorals s'hauria de realitzar mitjançant primàries obertes a tota la ciutadania."
                    }
                    {
                        lang: "es"
                        value: "La elección de los candidatos de las listas electorales debería realizarse mediante primarias abiertas a la ciudadanía."
                    }
                ]
            }
            {
                _id: "question2"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Els diputats i les diputades haurien de fer pública la seva agenda de reunions realitzades en exercici de les seves funcions representatives."
                    }
                    {
                        lang: "es"
                        value: "Los diputados y las diputadas deberían hacer pública su agenda de reuniones realizadas en ejercicio de sus funciones representativas."
                    }
                ]
            }
            {
                _id: "question3"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "S'hauria de publicar la declaració de béns dels diputats i diputades a l'inici i al final de cada legislatura."
                    }
                    {
                        lang: "es"
                        value: "Se debería publicar la declaración de bienes de diputados y diputadas al inicio y al final de cada legislatura."
                    }
                ]
            }
            {
                _id: "question4"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Totes les decisions polítiques rellevants haurien de ser consultades a la ciutadania."
                    }
                    {
                        lang: "es"
                        value: "Todas las decisiones políticas relevantes deberían ser consultadas a la ciudadanía."
                    }
                ]
            }
            {
                _id: "question5"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "En el context polític actual, les properes eleccions del dia 27 de setembre al Parlament de Catalunya són unes eleccions autonòmiques ordinàries."
                    }
                    {
                        lang: "es"
                        value: "En el contexto político actual, las próximas elecciones del día 27 de septiembre al Parlamento de Cataluña son unas elecciones autonómicas ordinarias."
                    }
                ]
            }
            {
                _id: "question6"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Si les llistes que es presenten a favor de la independència de Catalunya aconseguissin majoria absoluta, s’hauria d'iniciar un procés per separar-se de l'Estat espanyol."
                    }
                    {
                        lang: "es"
                        value: "Si las listas que se presentan a favor de la independencia de Cataluña consiguieran mayoría absoluta, deberían iniciar un proceso para separarse del Estado español."
                    }
                ]
            }
            {
                _id: "question7"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "M'agradaria que Catalunya continués formant part de l'Estat espanyol en les condicions actuals."
                    }
                    {
                        lang: "es"
                        value: "Me gustaría que Cataluña continuara formando parte del Estado español en las condiciones actuales."
                    }
                ]
            }
            {
                _id: "question8"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "La immersió lingüística és una bona eina per millorar la qualitat educativa que reben els estudiants catalans."
                    }
                    {
                        lang: "es"
                        value: "La inmersión lingüística es una buena herramienta para mejorar la calidad educativa que reciben los estudiantes catalanes."
                    }
                ]
            }
            {
                _id: "question9"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "L'acció exterior de Catalunya suposa una duplicitat i és una despesa innecesària."
                    }
                    {
                        lang: "es"
                        value: "La acción exterior de Cataluña supone una duplicidad y un gasto innecesario."
                    }
                ]
            }
            {
                _id: "question10"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "La Generalitat hauria de finançar el sector cultural, especialment per promoure la cultura catalana."
                    }
                    {
                        lang: "es"
                        value: "La Generalitat debería financiar el sector cultural, especialmente para promover la cultura catalana."
                    }
                ]
            }
            {
                _id: "question11"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "La ciutadania hauria de pagar pels serveis socials, i fer-ho en funció del seu nivell econòmic."
                    }
                    {
                        lang: "es"
                        value: "La ciudadanía debería pagar por los servicios sociales, y hacerlo en función de su nivel económico."
                    }
                ]
            }
            {
                _id: "question12"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Tothom hauria de tenir accés gratuït a la sanitat pública, independentment del seu nivell de renda i el seu lloc de procedència."
                    }
                    {
                        lang: "es"
                        value: "Todo el mundo debería tener acceso gratuito a la sanidad pública, independientemente de su nivel de renta y su lugar de procedencia."
                    }
                ]
            }
            {
                _id: "question13"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Les polítiques d'austeritat són inevitables a causa de la situació de crisi econòmica actual."
                    }
                    {
                        lang: "es"
                        value: "Las políticas de austeridad son inevitables a causa de la situación de crisis económica actual."
                    }
                ]
            }
            {
                _id: "question14"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "La despesa de la Generalitat no ha de poder superar els seus ingressos, encara que això suposi una limitació de la despesa social."
                    }
                    {
                        lang: "es"
                        value: "El gasto de la Generalitat no debe poder superar sus ingresos, aunque esto suponga una limitación del gasto social."
                    }
                ]
            }
            {
                _id: "question15"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "S'hauria d'incentivar l'ús habitual del transport públic, mitjançant la subvenció o la bonificació."
                    }
                    {
                        lang: "es"
                        value: "Se debería incentivar el uso habitual del transporte público mediante su subvención o bonificación."
                    }
                ]
            }
            {
                _id: "question16"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "La Generalitat hauria d'impulsar l'assimilació de la cultura catalana per part de les persones immigrades, més que no pas el manteniment de les seves pròpies tradicions."
                    }
                    {
                        lang: "es"
                        value: "La Generalitat debería de impulsar la asimilación de la cultura catalana por parte de las personas inmigradas, en vez del mantenimiento de sus propias tradiciones."
                    }
                ]
            }
            {
                _id: "question17"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "S'hauria de limitar el dret a la manifestació per no alterar l'ordre públic."
                    }
                    {
                        lang: "es"
                        value: "Se debería limitar el derecho a la manifestación para no alterar el orden público."
                    }
                ]
            }
            {
                _id: "question18"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Les parelles del mateix sexe tenen dret a adoptar fills en els mateixos termes que les parelles heterosexuals."
                    }
                    {
                        lang: "es"
                        value: "Las parejas del mismo sexo deben tener derecho a adoptar hijos en los mismos términos que las parejas heterosexuales."
                    }
                ]
            }
            {
                _id: "question19"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "En el context actual, les quotes de paritat de gènere són necessàries per assegurar la igualtat de representació entre dones i homes."
                    }
                    {
                        lang: "es"
                        value: "En el contexto actual, las cuotas de paridad de género son necesarias para asegurar la igualdad de representación entre mujeres y hombres."
                    }
                ]
            }
            {
                _id: "question20"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Per tal de reduir certes activitats delictives s'hauria de combatre la immigració irregular."
                    }
                    {
                        lang: "es"
                        value: "Con el objetivos de reducir determinados comportamientos delictivos se debería combatir la inmigración irregular."
                    }
                ]
            }
            {
                _id: "question21"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "El Govern hauria de prioritzar la inversió en Rodalies, en lloc de l'Alta Velocitat."
                    }
                    {
                        lang: "es"
                        value: "El Gobierno de la Generalitat debería priorizar la inversión en Cercanías, en vez de la Alta Velocidad."
                    }
                ]
            }
            {
                _id: "question22"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "S'hauria de gravar amb més impostos la compra dels vehicles d'alta cilindrada o que consumeixin molt."
                    }
                    {
                        lang: "es"
                        value: "Se debería gravar con más impuestos la compra de los vehículos de alta cilindrada o que consuman mucho."
                    }
                ]
            }
            {
                _id: "question23"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "La Generalitat hauria d’impulsar la producció pública i privada (autoconsum) d’energies renovables."
                    }
                    {
                        lang: "es"
                        value: "La Generalitat debería impulsar la producción pública y privada (autoconsumo) de energías renovables."
                    }
                ]
            }
            {
                _id: "question24"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Quan es parla de política, normalment s’utilitzen les expressions esquerra i dreta. On t’ubicaries en una escala del 0 al 10, on 0 significa extrema esquerra i 10 extrema dreta?"
                    }
                    {
                        lang: "es"
                        value: "Cuando se habla de política, normalmente se utilizan las expresiones “izquierda” y “derecha”. ¿Dónde te ubicarías en una escala del 0 al 10, en la que 0 significa extrema izquierda y 10 extrema derecha?"
                    }
                ]
            }
            {
                _id: "question25"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Algunes candidatures han plantejat aquestes eleccions com a plebiscitàries pel que fa a la relació entre Catalunya i l’Estat espanyol. On t’ubicaries en una escala del 0 al 10, on 0 equival a un Estat espanyol centralitzat, 5 al manteniment de l’status quo i 10 a un Estat propi per a Catalunya?"
                    }
                    {
                        lang: "es"
                        value: "Algunas candidaturas han planteado estas elecciones como plebiscitarias por lo que a la relación entre Cataluña y el Estado español respecta. ¿Dónde te ubicarías en una escala del 0 al 10, en la que 0 equivale a un Estado español centralizado, 5 al mantenimiento del status quo y 10 a un Estado propio para Cataluña?"
                    }
                ]
            }
            {
                _id: "question26"
                type: "politicalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Per acabar, ordena els següents blocs temàtics segons com d'importants siguin per a tu a l'hora de votar (com més amunt, més important)."
                    }
                    {
                        lang: "es"
                        value: "Para terminar, ordena los siguientes bloques temáticos en función de la importancia que tengan para ti a la hora de ir a votar (cuanto más arriba, más importante)."
                    }
                ]
            }
            {
                _id: "personalQuestionsError"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Ho sentim, s'ha produït un error durant la càrrega del qüestionari personal."
                    }
                    {
                        lang: "es"
                        value: "Lo sentimos, se ha producido un error durante la carga del cuestionario personal."
                    }
                ]
            }
            {
                _id: "personalQuestionsLoading"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "S'està carregant el qüestionari personal, només serà un moment..."
                    }
                    {
                        lang: "es"
                        value: "Se está cargando el cuestionario personal, solo será un momento..."
                    }
                ]
            }
            {
                _id: "sendResultsErrorNoMoreClick"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Ho sentim, s'ha produït un error en enviar les respostes. S'ha superat el límit de reintents, si torna a clicar el botó se'l portarà a la pàgina del questionari. Disculpi les molèsties."
                    }
                    {
                        lang: "es"
                        value: "Lo sentimos, se ha producido un error al enviar las respuestas. Se ha superado el límite de reintentos, si vuelve a pulsar el botón se le llevará a la página del cuestionario. Disculpe las molestias."
                    }
                ]
            }
            {
                _id: "sendResultsError"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Ho sentim, s'ha produït un error en enviar les respostes. Torni a intentar-ho clicant de nou al botó 'VEURE RESULTATS', tot i que és molt probable que hagi de tornar a començar el qüestionari de nou."
                    }
                    {
                        lang: "es"
                        value: "Lo sentimos, se ha producido un error al enviar las respuestas. Vuelva a intentarlo pulsando de nuevo el botón 'VER RESULTADOS', aunque es bastante probable que tenga que iniciar el cuestionario de nuevo."
                    }
                ]
            }
            {
                _id: "sendResultsTooLongDelay"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Sembla que l'enviament de les respostes està trigant massa. Comprovi la seva connexió a Internet i no tanqui la pàgina, les respostes s'enviaràn automàticament quan torni a tenir connexió."
                    }
                    {
                        lang: "es"
                        value: "Parece que la subida de las respuestas está tardando demasiado. Compruebe su conexión a Internet y no cierre la página, las respuestas se enviarán automáticamente cuando vuelva a tener conexión."
                    }
                ]
            }
            {
                _id: "sendingResults"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Enviant les respostes..."
                    }
                    {
                        lang: "es"
                        value: "Enviando las respuestas..."
                    }
                ]
            }
            {
                _id: "personalQuestionsInfo"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Les dades que ens proporcionis seran tractades amb confidencialitat i assegurem l’anonimat de les teves respostes.<br/>Si disposem de més dades podrem ubicar les teves preferències de manera més concreta dins del mapa polític català. Gràcies!"
                    }
                    {
                        lang: "es"
                        value: "Los datos que nos proporciones serán tratados con confidencialidad y aseguramos el anonimato de tus respuestas.<br/>Si disponemos de más datos, podremos ubicar tus preferencias de manera más concreta dentro del mapa político catalán. Gracias!"
                    }
                ]
            }
            {
                _id: "age"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Edat:"
                    }
                    {
                        lang: "es"
                        value: "Edad:"
                    }
                ]
            }
            {
                _id: "ageExport"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Edat"
                    }
                    {
                        lang: "es"
                        value: "Edad"
                    }
                ]
            }
            {
                _id: "<18"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "<18"
                    }
                    {
                        lang: "es"
                        value: "<18"
                    }
                ]
            }
            {
                _id: "18-24"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "18-24"
                    }
                    {
                        lang: "es"
                        value: "18-24"
                    }
                ]
            }
            {
                _id: "25-34"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "25-34"
                    }
                    {
                        lang: "es"
                        value: "25-34"
                    }
                ]
            }
            {
                _id: "35-44"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "35-44"
                    }
                    {
                        lang: "es"
                        value: "35-44"
                    }
                ]
            }
            {
                _id: "45-54"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "45-54"
                    }
                    {
                        lang: "es"
                        value: "45-54"
                    }
                ]
            }
            {
                _id: "55-64"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "55-64"
                    }
                    {
                        lang: "es"
                        value: "55-64"
                    }
                ]
            }
            {
                _id: "+64"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "+64"
                    }
                    {
                        lang: "es"
                        value: "+64"
                    }
                ]
            }
            {
                _id: "genre"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Gènere:"
                    }
                    {
                        lang: "es"
                        value: "Género:"
                    }
                ]
            }
            {
                _id: "genreExport"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Gènere"
                    }
                    {
                        lang: "es"
                        value: "Género"
                    }
                ]
            }
            {
                _id: "male"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Masculí"
                    }
                    {
                        lang: "es"
                        value: "Masculino"
                    }
                ]
            }
            {
                _id: "female"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Femení"
                    }
                    {
                        lang: "es"
                        value: "Femenino"
                    }
                ]
            }
            {
                _id: "otherSex"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Altres"
                    }
                    {
                        lang: "es"
                        value: "Otros"
                    }
                ]
            }
            {
                _id: "postalCode"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Codi Postal:"
                    }
                    {
                        lang: "es"
                        value: "Código Postal:"
                    }
                ]
            }
            {
                _id: "postalCodeExport"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Codi Postal"
                    }
                    {
                        lang: "es"
                        value: "Código Postal"
                    }
                ]
            }
            {
                _id: "personalQuestionsOptionalIntro"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "A continuació, et demanem que constestis les següents preguntes opcionals."
                    }
                    {
                        lang: "es"
                        value: "A continuación, te pedimos que contestes a las siguientes preguntas opcionales."
                    }
                ]
            }
            {
                _id: "educationLevel"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Nivell educatiu:"
                    }
                    {
                        lang: "es"
                        value: "Nivel educativo:"
                    }
                ]
            }
            {
                _id: "educationLevelExport"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Nivell educatiu"
                    }
                    {
                        lang: "es"
                        value: "Nivel educativo"
                    }
                ]
            }
            {
                _id: "noStudies"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Cap"
                    }
                    {
                        lang: "es"
                        value: "Ninguno"
                    }
                ]
            }
            {
                _id: "primaryStudies"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Estudis Primaris"
                    }
                    {
                        lang: "es"
                        value: "Estudios Primarios"
                    }
                ]
            }
            {
                _id: "secondaryStudies"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Estudis Secundaris"
                    }
                    {
                        lang: "es"
                        value: "Estudios Secundarios"
                    }
                ]
            }
            {
                _id: "professionalFormation"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Formació professional"
                    }
                    {
                        lang: "es"
                        value: "Formación Profesional"
                    }
                ]
            }
            {
                _id: "superiorStudies"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Estudis Superiors"
                    }
                    {
                        lang: "es"
                        value: "Estudios Superiores"
                    }
                ]
            }
            {
                _id: "postgraduateStudies"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Estudis de Postgrau"
                    }
                    {
                        lang: "es"
                        value: "Estudios de Postgrado"
                    }
                ]
            }
            {
                _id: "cotidianLanguage"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Llengua d'ús habitual:"
                    }
                    {
                        lang: "es"
                        value: "Lengua de uso habitual:"
                    }
                ]
            }
            {
                _id: "cotidianLanguageExport"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Llengua d'ús habitual"
                    }
                    {
                        lang: "es"
                        value: "Lengua de uso habitual"
                    }
                ]
            }
            {
                _id: "catalan"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Català"
                    }
                    {
                        lang: "es"
                        value: "Catalán"
                    }
                ]
            }
            {
                _id: "spanish"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Castellà"
                    }
                    {
                        lang: "es"
                        value: "Castellano"
                    }
                ]
            }
            {
                _id: "bothLanguages"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Ambdues"
                    }
                    {
                        lang: "es"
                        value: "Ambas"
                    }
                ]
            }
            {
                _id: "votingRecord"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Record de vot (que vas votar a les eleccions al Parlament de Catalunya de 2012):"
                    }
                    {
                        lang: "es"
                        value: "Recuerdo de Voto ( que votaste en las elecciones al Parlamento de Cataluña de 2012):"
                    }
                ]
            }
            {
                _id: "votingRecordExport"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Record de vot"
                    }
                    {
                        lang: "es"
                        value: "Recuerdo de Voto"
                    }
                ]
            }
            {
                _id: "otherVotingRecord"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Altres"
                    }
                    {
                        lang: "es"
                        value: "Otros"
                    }
                ]
            }
            {
                _id: "white"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Blanc"
                    }
                    {
                        lang: "es"
                        value: "Blanco"
                    }
                ]
            }
            {
                _id: "null"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Nul"
                    }
                    {
                        lang: "es"
                        value: "Nulo"
                    }
                ]
            }
            {
                _id: "abstention"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Abstenció"
                    }
                    {
                        lang: "es"
                        value: "Abstención"
                    }
                ]
            }
            {
                _id: "votingIntention"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Intenció de vot (Si demà es celebressin les eleccions al Parlament de Catalunya, a quin partit o coalició votaries):"
                    }
                    {
                        lang: "es"
                        value: "Intención de voto (si mañana se celebrasen las elecciones al Parlamento de Cataluña, a qué partido o coalición votarías):"
                    }
                ]
            }
            {
                _id: "votingIntentionExport"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Intenció de vot"
                    }
                    {
                        lang: "es"
                        value: "Intención de voto"
                    }
                ]
            }
            {
                _id: "endQuestionaireText"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Moltes gràcies,<br/>a continuació pots veure els teus resultats!"
                    }
                    {
                        lang: "es"
                        value: "Muchas gracias,<br/>a continuación puedes ver tus resultados!"
                    }
                ]
            }
            {
                _id: "seeResults"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Veure resultats"
                    }
                    {
                        lang: "es"
                        value: "Ver resultados"
                    }
                ]
            }
            {
                _id: "personalQuestionsAlert"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "Abans de poder accedir als resultats, cal que responguis totes les preguntes obligatòries"
                    }
                    {
                        lang: "es"
                        value: "Antes de poder acceder a los resultados, es necesario que respondas todas las preguntas obligatorias"
                    }
                ]
            }
            {
                _id: "incorrectPostalCode"
                type: "personalQuestions"
                translations: [
                    {
                        lang: "ca"
                        value: "El codi postal és incorrecte"
                    }
                    {
                        lang: "es"
                        value: "El código postal es incorrecto"
                    }
                ]
            }
            {
                _id: "downloadForIeNotSupported"
                type: "results"
                translations: [
                    {
                        lang: "ca"
                        value: "Ho sentim, no és possible la baixada del gràfic en el teu navegador. De moment només és possible en els navegadors Chrome i Mozilla Firefox."
                    }
                    {
                        lang: "es"
                        value: "Lo sentimos, no es posible la bajada del gráfico en tu navegador. Por ahora solo es posible con los navegadores Chrome i Mozilla Firefox."
                    }
                ]
            }
            {
                _id: "resultsError"
                type: "results"
                translations: [
                    {
                        lang: "ca"
                        value: "Ho sentim, s'ha produït un error en carregar els resultats. Torni a intentar-ho."
                    }
                    {
                        lang: "es"
                        value: "Lo sentimos, se ha producido un error en cargar los resultados. Torni a intentar-ho."
                    }
                ]
            }
            {
                _id: "resultsLoading"
                type: "results"
                translations: [
                    {
                        lang: "ca"
                        value: "S'estàn carregant els resultats, només serà un moment..."
                    }
                    {
                        lang: "es"
                        value: "Se están cargando los resultados, solo será un momento..."
                    }
                ]
            }
            {
                _id: "badResultsId"
                type: "results"
                translations: [
                    {
                        lang: "ca"
                        value: "Ho sentim! Sembla que l'enllaç de resultats que has introduït és incorrecte"
                    }
                    {
                        lang: "es"
                        value: "Lo sentimos! Parece que el enlace de resultados que has introducido es incorrecto"
                    }
                ]
            }
            {
                _id: "yourResultsTitle"
                type: "results"
                translations: [
                    {
                        lang: "ca"
                        value: "Els teus resultats"
                    }
                    {
                        lang: "es"
                        value: "Tus resultados"
                    }
                ]
            }
            {
                _id: "yourResultsTitleOut"
                type: "results"
                translations: [
                    {
                        lang: "ca"
                        value: "Resultats"
                    }
                    {
                        lang: "es"
                        value: "Resultados"
                    }
                ]
            }
            {
                _id: "yourResultsText"
                type: "results"
                translations: [
                    {
                        lang: "ca"
                        value: "Ara pots visualitzar els gràfics amb els teus resultats<br/>Descobreix amb quines candidatures coincideixes més!"
                    }
                    {
                        lang: "es"
                        value: "Ahora puedes visualizar los gráficos con tus resultados<br/>Descubre las candidatura con las que más coincides!"
                    }
                ]
            }
            {
                _id: "yourResultsTextOut"
                type: "results"
                translations: [
                    {
                        lang: "ca"
                        value: "Aquests són els resultats obtinguts a partir del qüestionari. Si vols saber com els hem calculat, consulta la <a href='/com-ho-hem-fet'>metodologia</a>. I si vols que els teus amics i amigues els coneguin, comparteix-los a les xarxes socials."
                    }
                    {
                        lang: "es"
                        value: "Estos son los resultados obtenidos a partir del cuestionario. Si quieres saber cómo los hemos calculado, consulta la <a href='/com-ho-hem-fet'>metodología</a>. Y si quieres que tus amigos y amigas los conozcan, compártelos en las redes sociales."
                    }
                ]
            }
            {
                _id: "partyCoincidence"
                type: "results"
                translations: [
                    {
                        lang: "ca"
                        value: "Coincidència amb els partits"
                    }
                    {
                        lang: "es"
                        value: "Coincidencia con los partidos"
                    }
                ]
            }
            {
                _id: "topicCoincidence"
                type: "results"
                translations: [
                    {
                        lang: "ca"
                        value: "Coincidència per temes"
                    }
                    {
                        lang: "es"
                        value: "Coincidencia por temas"
                    }
                ]
            }
            {
                _id: "location"
                type: "results"
                translations: [
                    {
                        lang: "ca"
                        value: "Ubicació"
                    }
                    {
                        lang: "es"
                        value: "Ubicación"
                    }
                ]
            }
            {
                _id: "parlamentaryRepresentation"
                type: "results"
                translations: [
                    {
                        lang: "ca"
                        value: "Representació parlamentària"
                    }
                    {
                        lang: "es"
                        value: "Representación parlamentaria"
                    }
                ]
            }
            {
                _id: "download"
                type: "results"
                translations: [
                    {
                        lang: "ca"
                        value: "Descàrrega"
                    }
                    {
                        lang: "es"
                        value: "Descarga"
                    }
                ]
            }
            {
                _id: "share"
                type: "results"
                translations: [
                    {
                        lang: "ca"
                        value: "Comparteix:"
                    }
                    {
                        lang: "es"
                        value: "Comparte:"
                    }
                ]
            }
            {
                _id: "resultsCodeText"
                type: "results"
                translations: [
                    {
                        lang: "ca"
                        value: "Guarda aquest enllaç. Et permetrà recuperar els teus resultats quan vulguis."
                    }
                    {
                        lang: "es"
                        value: "Guarda este enlace. Te permitirá recuperar tus resultados cuando lo desees."
                    }
                ]
            }
            {
                _id: "left"
                type: "locationGraph"
                translations: [
                    {
                        lang: "ca"
                        value: "Esquerra"
                    }
                    {
                        lang: "es"
                        value: "Izquierdas"
                    }
                ]
            }
            {
                _id: "right"
                type: "locationGraph"
                translations: [
                    {
                        lang: "ca"
                        value: "Dreta"
                    }
                    {
                        lang: "es"
                        value: "Derechas"
                    }
                ]
            }
            {
                _id: "independentism"
                type: "locationGraph"
                translations: [
                    {
                        lang: "ca"
                        value: "Estat independent per a Catalunya"
                    }
                    {
                        lang: "es"
                        value: "Estado independiente para Cataluña"
                    }
                ]
            }
            {
                _id: "unionism"
                type: "locationGraph"
                translations: [
                    {
                        lang: "ca"
                        value: "Estat espanyol centralitzat"
                    }
                    {
                        lang: "es"
                        value: "Estado español centralizado"
                    }
                ]
            }
            {
                _id: "you"
                type: "locationGraph"
                translations: [
                    {
                        lang: "ca"
                        value: "Tu"
                    }
                    {
                        lang: "es"
                        value: "Tú"
                    }
                ]
            }
            {
                _id: "regeneracioDemocratica"
                type: "topics"
                translations: [
                    {
                        lang: "ca"
                        value: "Regeneració Democràtica"
                    }
                    {
                        lang: "es"
                        value: "Regeneración Democrática"
                    }
                ]
            }
            {
                _id: "modelTerritorial"
                type: "topics"
                translations: [
                    {
                        lang: "ca"
                        value: "Model Territorial"
                    }
                    {
                        lang: "es"
                        value: "Modelo Territorial"
                    }
                ]
            }
            {
                _id: "estatDelBenestar"
                type: "topics"
                translations: [
                    {
                        lang: "ca"
                        value: "Estat de Benestar"
                    }
                    {
                        lang: "es"
                        value: "Estado del Bienestar"
                    }
                ]
            }
            {
                _id: "ciutadania"
                type: "topics"
                translations: [
                    {
                        lang: "ca"
                        value: "Ciutadania"
                    }
                    {
                        lang: "es"
                        value: "Ciudadanía"
                    }
                ]
            }
            {
                _id: "territoriEcologiaIMediAmbient"
                type: "topics"
                translations: [
                    {
                        lang: "ca"
                        value: "Territori, Ecologia i Medi Ambient"
                    }
                    {
                        lang: "es"
                        value: "Territorio, Ecología y Medio Ambiente"
                    }
                ]
            }
            {
                _id: "CIU"
                type: "parties"
                translations: [
                    {
                        lang: "ca"
                        value: "CiU"
                    }
                    {
                        lang: "es"
                        value: "CiU"
                    }
                ]
            }
            {
                _id: "PSC"
                type: "parties"
                translations: [
                    {
                        lang: "ca"
                        value: "PSC"
                    }
                    {
                        lang: "es"
                        value: "PSC"
                    }
                ]
            }
            {
                _id: "PPC"
                type: "parties"
                translations: [
                    {
                        lang: "ca"
                        value: "PPC"
                    }
                    {
                        lang: "es"
                        value: "PPC"
                    }
                ]
            }
            {
                _id: "Cs"
                type: "parties"
                translations: [
                    {
                        lang: "ca"
                        value: "C's"
                    }
                    {
                        lang: "es"
                        value: "C's"
                    }
                ]
            }
            {
                _id: "ICV-EUIA"
                type: "parties"
                translations: [
                    {
                        lang: "ca"
                        value: "ICV-EUiA"
                    }
                    {
                        lang: "es"
                        value: "ICV-EUiA"
                    }
                ]
            }
            {
                _id: "CUP"
                type: "parties"
                translations: [
                    {
                        lang: "ca"
                        value: "CUP"
                    }
                    {
                        lang: "es"
                        value: "CUP"
                    }
                ]
            }
            {
                _id: "ERC"
                type: "parties"
                translations: [
                    {
                        lang: "ca"
                        value: "ERC"
                    }
                    {
                        lang: "es"
                        value: "ERC"
                    }
                ]
            }
            {
                _id: "CSQEP"
                type: "parties"
                translations: [
                    {
                        lang: "ca"
                        value: "Catalunya Sí que es Pot"
                    }
                    {
                        lang: "es"
                        value: "Catalunya Sí que es Pot"
                    }
                ]
            }
            {
                _id: "JxS"
                type: "parties"
                translations: [
                    {
                        lang: "ca"
                        value: "Junts pel Sí"
                    }
                    {
                        lang: "es"
                        value: "Junts pel Sí"
                    }
                ]
            }
            {
                _id: "UDC"
                type: "parties"
                translations: [
                    {
                        lang: "ca"
                        value: "Unió"
                    }
                    {
                        lang: "es"
                        value: "Unió"
                    }
                ]
            }
            {
                _id: "CIUTooltip"
                type: "parties"
                translations: [
                    {
                        lang: "ca"
                        value: "Convergència i Unió"
                    }
                    {
                        lang: "es"
                        value: "Convergencia y Unión"
                    }
                ]
            }
            {
                _id: "PSCTooltip"
                type: "parties"
                translations: [
                    {
                        lang: "ca"
                        value: "Partit Socialista de Catalunya"
                    }
                    {
                        lang: "es"
                        value: "Partido Socialista de Cataluña"
                    }
                ]
            }
            {
                _id: "PPCTooltip"
                type: "parties"
                translations: [
                    {
                        lang: "ca"
                        value: "Partit Popular de Catalunya"
                    }
                    {
                        lang: "es"
                        value: "Partido Popular de Cataluña"
                    }
                ]
            }
            {
                _id: "CsTooltip"
                type: "parties"
                translations: [
                    {
                        lang: "ca"
                        value: "Ciutadans"
                    }
                    {
                        lang: "es"
                        value: "Ciutadans"
                    }
                ]
            }
            {
                _id: "ICV-EUIATooltip"
                type: "parties"
                translations: [
                    {
                        lang: "ca"
                        value: "Iniciativa per Catalunya Verds - Esquerra Unida i Alternativa"
                    }
                    {
                        lang: "es"
                        value: "Iniciativa per Catalunya Verds - Esquerra Unida i Alternativa"
                    }
                ]
            }
            {
                _id: "CUPTooltip"
                type: "parties"
                translations: [
                    {
                        lang: "ca"
                        value: "Candidatura d'Unitat Popular"
                    }
                    {
                        lang: "es"
                        value: "Candidatura de Unidad Popular"
                    }
                ]
            }
            {
                _id: "ERCTooltip"
                type: "parties"
                translations: [
                    {
                        lang: "ca"
                        value: "Esquerra Republicana de Catalunya"
                    }
                    {
                        lang: "es"
                        value: "Izquierda Republicana de Cataluña"
                    }
                ]
            }
            {
                _id: "UDCTooltip"
                type: "parties"
                translations: [
                    {
                        lang: "ca"
                        value: "Unió Democràtica de Catalunya"
                    }
                    {
                        lang: "es"
                        value: "Unión Democrática de Cataluña"
                    }
                ]
            }
            {
                _id: "spaces"
                type: "other"
                translations: [
                    {
                        lang: "ca"
                        value: "&nbsp;&nbsp;"
                    }
                    {
                        lang: "es"
                        value: "&nbsp;&nbsp;"
                    }
                ]
            }
            {
                _id: "catalanLangOption"
                type: "other"
                translations: [
                    {
                        lang: "ca"
                        value: "català"
                    }
                    {
                        lang: "es"
                        value: "català"
                    }
                ]
            }
            {
                _id: "spanishLangOption"
                type: "other"
                translations: [
                    {
                        lang: "ca"
                        value: "castellano"
                    }
                    {
                        lang: "es"
                        value: "castellano"
                    }
                ]
            }
        ]

        for translation in TRANSLATIONS
            possibleSameTranslation = Translations.findOne({ _id: translation._id })
            unless possibleSameTranslation?
                Translations.insert(translation, (err, res) ->
                    console.error err if err
                )

    Meteor.startup( ->
        createTopics()
        createPoliticalParties()
        createPoliticalQuestions()
        createPersonalQuestions()
        createAdminUser()
        createTranslations()
    )

