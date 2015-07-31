# Language translations

    Translator = ($translateProvider) ->
        $translateProvider.translations('ca',
            welcomeIntroText: 'Descobreix la teva posició dins del mapa polític català i decideix quin serà El teu Vot'
            welcomeStart: 'Comença'
            navYourVote: 'El teu vot'
            navMethodology: 'Metodologia'
            navWhoAreWe: 'Qui som'

            whoWeAreLeftText: 'El teu Vot és un recomanador de vot d’àmbit català, creat
                                en el marc de les eleccions del 27 de setembre. Un
                                recomanador de vot és una eina electrònica que permet
                                ubicar a l’elector dins d’un context polític determinat. El Teu
                                Vot pren la forma de web, que a partir d’un senzill
                                qüestionari, ubica a l’usuari (elector) ideològicament,
                                entorn a uns temes concrets, respecte als partits que
                                concorren en el procés electoral del 27 de setembre. Així
                                l’usuari obtindrà una sèrie de gràfics que li permetrà
                                veure de manera atractiva i senzilla quin és el partit més
                                afí a les seves preferenices. Els recomanadors de vot són
                                quelcom habitual en els períodes previs a les eleccions.
                                Durant les campanyes electorals acostumen a aparèixer
                                webs que realitzen la funció d’ubicar l’elector en l’escenari
                                electoral. El Teu Vot és una iniciativa que es construeix des
                                del rigor metodològic i la total independència respecte
                                partits i institucions públiques, dos trets distintius
                                essencials que aporten un valor afegit respecte altres
                                plataformes similars.'

            whoWeAreRightText: 'El teu Vot és un projecte que neix de la col·laboració entre
                                El teu Parlament i Apps4citizens. El teu Parlament és una
                                organització de monitoratge parlamentari (OMP)
                                impulsada per quatre politòlegs de la Universitat Pompeu
                                Fabra. Com a OMP, El teu Parlament és una organització
                                independent i sense ànim de lucre, que té per objectiu
                                la millora de la transparència de la institució que
                                monitoritza; el Parlament de Catalunya. Mitjançant la
                                creació d’eines electròniques, El teu Parlament vol
                                promoure la cultura de la transparència per tal
                                d’aconseguir un debat públic més profund i de major
                                qualitat, que ajudi a incrementar la cultura política
                                ciutadana en la recerca d’un sistema democràtic millor. Per
                                la seva banda, Apps4citizens s’articula com un projecte que
                                te com a objectiu principal promoure l’ús d’aplicacions
                                mòbils com un instrument útil per millorar la qualitat
                                democràtica dels processos de presa de decisions a través
                                del compromís social y polític dels propis ciutadans.'
        );

        $translateProvider.translations('es',
            welcomeIntroText: 'Descubre tu posición dentro del mapa político catalán y decide cual será tu voto'
            welcomeStart: 'Empezar'
            navYourVote: 'El teu vot'
            navMethodology: 'Metodología'
            navWhoAreWe: 'Quienes somos'

            whoWeAreLeftText: 'El teu Vot és un recomanador de vot d’àmbit català, creat
                                en el marc de les eleccions del 27 de setembre. Un
                                recomanador de vot és una eina electrònica que permet
                                ubicar a l’elector dins d’un context polític determinat. El Teu
                                Vot pren la forma de web, que a partir d’un senzill
                                qüestionari, ubica a l’usuari (elector) ideològicament,
                                entorn a uns temes concrets, respecte als partits que
                                concorren en el procés electoral del 27 de setembre. Així
                                l’usuari obtindrà una sèrie de gràfics que li permetrà
                                veure de manera atractiva i senzilla quin és el partit més
                                afí a les seves preferenices. Els recomanadors de vot són
                                quelcom habitual en els períodes previs a les eleccions.
                                Durant les campanyes electorals acostumen a aparèixer
                                webs que realitzen la funció d’ubicar l’elector en l’escenari
                                electoral. El Teu Vot és una iniciativa que es construeix des
                                del rigor metodològic i la total independència respecte
                                partits i institucions públiques, dos trets distintius
                                essencials que aporten un valor afegit respecte altres
                                plataformes similars.'

            whoWeAreRightText: 'El teu Vot és un projecte que neix de la col·laboració entre
                                El teu Parlament i Apps4citizens. El teu Parlament és una
                                organització de monitoratge parlamentari (OMP)
                                impulsada per quatre politòlegs de la Universitat Pompeu
                                Fabra. Com a OMP, El teu Parlament és una organització
                                independent i sense ànim de lucre, que té per objectiu
                                la millora de la transparència de la institució que
                                monitoritza; el Parlament de Catalunya. Mitjançant la
                                creació d’eines electròniques, El teu Parlament vol
                                promoure la cultura de la transparència per tal
                                d’aconseguir un debat públic més profund i de major
                                qualitat, que ajudi a incrementar la cultura política
                                ciutadana en la recerca d’un sistema democràtic millor. Per
                                la seva banda, Apps4citizens s’articula com un projecte que
                                te com a objectiu principal promoure l’ús d’aplicacions
                                mòbils com un instrument útil per millorar la qualitat
                                democràtica dels processos de presa de decisions a través
                                del compromís social y polític dels propis ciutadans.'
        );

        $translateProvider.preferredLanguage('ca');


    app.config(['$translateProvider', Translator])