Events = new Meteor.Collection 'events'

Meteor.publish 'all-events', ()->
    user = Meteor.users.findOne {'_id': this.userId}
    if user != undefined and user.group == 'admin'
        return Events.find()
    return null

checkNewEventModel = (item) ->
    err = Object.keys(item).length == 6
    err &= Cartridges.findOne({_id: item.cartridgeId}) != null
    err &= EventTypes.findOne({id: (item.typeId)|0}) != undefined
    err &= (item.date.length == 24 && (item.date = new Date(item.date))) != null
    err &= item.comment != undefined
    err &= item.place != undefined
    return err

checkUpdateEventModel = (items, fields, modifier) ->
    err = true
    #err = items.length == 1
    err &= fields[0] == 'typeId'
    err &= fields[1] == 'date'
    err &= fields[2] == 'place'
    err &= fields[3] == 'comment'
    err &= Object.keys(modifier['$set']).length == 4
    err &= EventTypes.findOne({id: (modifier['$set'].typeId)|0}) != undefined
    err &= ((modifier['$set'].date.length == 24) && (modifier['$set'].date = new Date(modifier['$set'].date))) != null
    err &= modifier['$set'].comment != undefined
    err &= modifier['$set'].place != undefined
    return err

updateCartridge = (item) ->
    lastEvent = Events.findOne {'cartridgeId': item.cartridgeId}, {'sort': {'date': -1, 'lastChanges': -1}}

    lastState = null
    if lastEvent
        lastState = lastEvent.typeId
    now = new Date()
    selector =
        _id: item.cartridgeId
    modifier =
        $set:
            lastState: lastState
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
        if userId != null
            user = Meteor.users.findOne {'_id': userId}
            if user != undefined and user.group == 'admin'
                if checkNewEventModel item
                    now = new Date()
                    item.creationDate = now
                    item.lastChanges = now
                    item.owner = userId
                    return true
        return false

    update: (userId, items, fields, modifier) ->
        if userId != null
            user = Meteor.users.findOne {'_id': userId}
            if user != undefined and user.group == 'admin'
                if checkUpdateEventModel items, fields, modifier
                    now = new Date()
                    fields.push 'lastChanges'
                    modifier['$set'].lastChanges = now
                    return true
        return false

    remove: (userId, items) ->
        if userId != null
            user = Meteor.users.findOne {'_id': userId}
            if user != undefined and user.group == 'admin'
                return true
        return false

