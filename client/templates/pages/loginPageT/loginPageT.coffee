Template.loginPageT.events
    'keydown #login_form input': (e)->
        loginFromForm() if e.which == 13
    'click #loginBtn': ()->
        loginFromForm()
    'click #registerBtn': ()->
        registerFromForm()

loginFromForm = ()->
    login = $('#loginLogin').val()
    pass = $('#loginPassword').val()
    Meteor.loginWithPassword {username: login}, pass, (data) ->
        alertBox 'loginAlertBox', data.reason if data != undefined

registerFromForm = ()->
    login = $('#loginLogin').val()
    pass = $('#loginPassword').val()
    Accounts.createUser {username: login, password: pass}, (data) ->
        alertBox 'loginAlertBox', data.reason if data != undefined
