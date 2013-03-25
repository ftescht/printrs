Template.menu.isLogin = ()->
  return Meteor.user() != null

Template.menu.isAdmin = ()->
  return Meteor.user() and Meteor.user().group == 'admin'

Template.menu.isCartridges = ()->
  return "active" if Meteor.Router.page() == 'cartridgesPage'
  return ""

Template.menu.isPlaces = ()->
  return "active" if Meteor.Router.page() == 'placesPage'
  return ""

Template.menu.isUsers = ()->
  return "active" if Meteor.Router.page() == 'usersPage'
  return ""

Template.menu.isEventTypes = ()->
  return "active" if Meteor.Router.page() == 'eventTypesPage'
  return ""

Template.menu.events
  'click #logoutLink': () ->
    Meteor.logout()