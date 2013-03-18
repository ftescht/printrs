Template.menu.isLogin = ()->
    return Meteor.user() != null or Meteor.user() != undefined

Template.menu.isAdmin = ()->
    return Meteor.user() != undefined and Meteor.user().group == 'admin'