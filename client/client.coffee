
Meteor.subscribe "all-users"

Meteor.subscribe "all-eventtypes"
EventTypes = new Meteor.Collection "eventTypes"

Meteor.subscribe "all-cartridges"
Cartridges = new Meteor.Collection "cartridges"

Meteor.subscribe "all-events"
Events = new Meteor.Collection "events"

alertBox = (id, text) ->
    alertHtml = '<div class="alert"><a class="close" data-dismiss="alert" href="#">&times;</a><strong>'+text+'</strong></div>'
    $("#"+id).html(alertHtml)
