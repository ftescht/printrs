EventTypes = new Meteor.Collection "eventTypes"

Meteor.publish "all-eventtypes", ()->
    return EventTypes.find()

EventTypes.allow
    insert: (userId, item) ->
        return false
    update: (userId, items, fields, modifier) ->
        return false
    remove: (userId, items) ->
        return false