Template.menu_widget.isLogin = ()->
  return Meteor.user() != null

Template.menu_widget.isVisible = ()->
  if Meteor.user()
    return true
  return false

Template.menu_widget.isAdmin = ()->
  return Meteor.user() and Meteor.user().group == 'admin'

Template.menu_widget.isCartridges = ()->
  return "active" if Meteor.Router.page() == 'cartridgesPage'
  return ""

Template.menu_widget.isPlaces = ()->
  return "active" if Meteor.Router.page() == 'placesPage'
  return ""

Template.menu_widget.isPrinters = ()->
  return "active" if Meteor.Router.page() == 'printersPage'
  return ""

Template.menu_widget.isUsers = ()->
  return "active" if Meteor.Router.page() == 'usersPage'
  return ""

Template.menu_widget.isEventTypes = ()->
  return "active" if Meteor.Router.page() == 'eventTypesPage'
  return ""

Template.menu_widget.events
  'click #menu_widget_logout': () ->
    Meteor.logout()