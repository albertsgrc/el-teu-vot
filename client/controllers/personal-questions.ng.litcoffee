# Personal questions angular controller

    PersonalQuestionsCtrl = ($scope, $timeout) ->
        $timeout(-> $("body").scrollTop(0))

    app.controller('PersonalQuestionsCtrl', ['$scope', '$timeout', PersonalQuestionsCtrl])