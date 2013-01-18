Template.user.isLogin = ()->
    return Meteor.user() != null

Template.user.events
    'click #logoutLink': () ->
        Meteor.logout()
        $("#eventsPlace").html("")
        $("#cartridgeBox").html("")