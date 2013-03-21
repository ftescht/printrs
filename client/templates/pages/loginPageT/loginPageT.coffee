Template.loginPageT.events
    'click #loginBtn': () ->
        login = $('#loginLogin').val()
        pass = $('#loginPassword').val()
        Meteor.loginWithPassword {username: login}, pass, (data) ->
            if data != undefined
                alertBox 'loginAlertBox', data.reason

    'click #registerBtn': () ->
        login = $('#loginLogin').val()
        pass = $('#loginPassword').val()
        Accounts.createUser {username: login, password: pass}, (data) ->
            if data != undefined
                alertBox 'loginAlertBox', data.reason
