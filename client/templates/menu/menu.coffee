Template.menu.isLogin = ()->
    return Meteor.user() != null

Template.menu.isAdmin = ()->
    return Meteor.user() != null and Meteor.user().group == 'admin'