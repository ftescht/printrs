
Meteor.subscribe "all-users"

EventTypes = new Meteor.Collection "eventTypes"
Meteor.subscribe "all-eventtypes", ()->
    eTypes = EventTypes.find({})
    eTypes.forEach (item) ->
        addClassColor item.id, item.color

Cartridges = new Meteor.Collection "cartridges"
Meteor.subscribe "all-cartridges"

Events = new Meteor.Collection "events"
Meteor.subscribe "all-events"

alertBox = (id, text) ->
    alertHtml = '<div class="alert"><a class="close" data-dismiss="alert" href="#">&times;</a><strong>'+text+'</strong></div>'
    $("#"+id).html(alertHtml)

addClassColor = (id, color) ->
    style = $('<style>.eventType'+id+' { background: '+color+' !important; }</style>')
    $('html > head').append(style);
