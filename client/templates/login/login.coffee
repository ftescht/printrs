Meteor.startup ()->
    $('#loginWindow').on 'hidden', ()->
        $('#loginLogin').val null
        $('#loginPassword').val null

Template.login.events
    'click #loginBtn': () ->
        err = 0
        login = $('#loginLogin').val()
        pass = $('#loginPassword').val()
        Meteor.loginWithPassword {username: login}, pass, (data) ->
            if data != undefined
                alertBox 'loginAlertBox', data.reason
            else
                $('#loginWindow').modal('hide')
                
    'click #registerBtn': () ->
        err = 0
        login = $('#loginLogin').val()
        pass = $('#loginPassword').val()
        Accounts.createUser {username: login, password: pass}, (data) ->
            if data != undefined
                alertBox 'loginAlertBox', data.reason
            else
                $('#loginWindow').modal 'hide'