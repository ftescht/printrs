Template.login_page.events
  'keydown #login_form input': (e)->
    loginFromForm() if e.which == 13
  'click #login_form_login_button': ()->
    loginFromForm()
  'click #login_form_register_button': ()->
    registerFromForm()

loginFromForm = ()->
  login = $('#login_form_login').val()
  pass = $('#login_form_password').val()
  Meteor.loginWithPassword {username: login}, pass, (data) ->
    alertBox 'login_form_alert', data.reason if data != undefined

registerFromForm = ()->
  login = $('#login_form_login').val()
  pass = $('#login_form_password').val()
  Accounts.createUser {username: login, password: pass}, (data) ->
    alertBox 'login_form_alert', data.reason if data != undefined
