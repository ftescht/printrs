Events = new Meteor.Collection "events"

Meteor.publish "all-events", ()->
    user = Meteor.users.findOne({'_id': this.userId})
    if user != undefined and user.group == 'admin'
        return Events.find()
    return null

checkNewEventModel = (item) ->
    err = Object.keys(item).length == 5
    err &= Cartridges.findOne({_id: item.cartridgeId}) != null
    err &= EventTypes.findOne({id: item.typeId}) != null
    err &= item.date.length == 10
    err &= item.comment != undefined
    return err

checkUpdateEventModel = (items, fields, modifier) ->
    err = items.length == 1
    err &= fields[0] == 'typeId'
    err &= fields[1] == 'date'
    err &= fields[2] == 'comment'
    err &= Object.keys(modifier["$set"]).length == 3
    err &= EventTypes.findOne({id: modifier["$set"].typeId}) != null
    err &= modifier["$set"].date.length == 10
    err &= modifier["$set"].comment != undefined
    return err

updateCartridge = (item) ->
    lastEvent = Events.findOne({'cartridgeId': item.cartridgeId}, {'sort': {'date': -1, 'lastChanges': -1}})
    if lastEvent
        now = new Date()
        selector =
            _id: item.cartridgeId
        modifier =
            $set:
                lastState: lastEvent.typeId
                lastChanges: now
        Cartridges.update selector, modifier

query = Events.find()
handle = query.observe
    'added': (doc)->
        updateCartridge(doc)
    'changed': (doc)->
        updateCartridge(doc)
    'removed': (doc)->
        updateCartridge(doc)

Events.allow
    insert: (userId, item) ->
        if userId == null
            return false
        user = Meteor.users.findOne({'_id': userId})
        if user == undefined or user.group != 'admin'
            return false
        if checkNewEventModel item
            now = new Date()
            item.creationDate = now
            item.lastChanges = now
            item.owner = userId
            return true
        return false

    update: (userId, items, fields, modifier) ->
        if userId == null
            return false
        user = Meteor.users.findOne({'_id': userId})
        if user == undefined or user.group != 'admin'
            return false
        if checkUpdateEventModel items, fields, modifier
            now = new Date()
            fields.push "lastChanges"
            modifier["$set"].lastChanges = now
            fields.push "owner"
            modifier["$set"].owner = userId
            return true
        return false

    remove: (userId, items) ->
        if userId == null
            return false
        user = Meteor.users.findOne({'_id': userId})
        if user == undefined or user.group != 'admin'
            return false
        return true

