Events = new Meteor.Collection 'events'

Meteor.publish 'all-events', ()->
    user = Meteor.users.findOne {'_id': this.userId}
    if user != undefined and user.group == 'admin'
        return Events.find()
    return null

checkNewEventModel = (item) ->
    err = Object.keys(item).length == 6
    err &= Cartridges.findOne({ _id: item.cartridgeId }) != null
    err &= EventTypes.findOne({ _id: item.typeId }) != undefined
    err &= Places.findOne({ _id: item.placeId }) != undefined
    err &= (item.date.length == 24 && (item.date = new Date(item.date))) != null
    err &= item.comment != undefined
    return err

checkUpdateEventModel = (items, fields, modifier) ->
    err = true
    err &= fields[0] == 'typeId'
    err &= fields[1] == 'placeId'
    err &= fields[2] == 'date'
    err &= fields[3] == 'comment'
    err &= Object.keys(modifier['$set']).length == 4
    err &= EventTypes.findOne({ _id: modifier['$set'].typeId }) != undefined
    err &= Places.findOne({ _id: modifier['$set'].placeId }) != undefined
    err &= ((modifier['$set'].date.length == 24) && (modifier['$set'].date = new Date(modifier['$set'].date))) != null
    err &= modifier['$set'].comment != undefined
    return err

#updateCartridge = (item) ->
#    lastEvent = Events.findOne {'cartridgeId': item.cartridgeId}, {'sort': {'date': -1, 'lastChanges': -1}}
#
#    lastState = null
#    if lastEvent
#        lastState = lastEvent.typeId
#    selector =
#        _id: item.cartridgeId
#    modifier =
#        $set:
#            lastState: lastState
#            lastChanges: new Date()
#    Cartridges.update selector, modifier
#
#updatePlace = (item) ->
#    lastEvent = Events.findOne {'placeId': item.placeId}, {'sort': {'date': -1, 'lastChanges': -1}}
#
#    lastState = null
#    if lastEvent
#        lastState = lastEvent.typeId
#    selector =
#        _id: item.placeId
#    modifier =
#        $set:
#            lastState: lastState
#            lastChanges: new Date()
#    Places.update selector, modifier
#
#query = Events.find()
#handle = query.observe
#    'changed': (doc)->
#        updateCartridge(doc)
#        updatePlace(doc)
#    'added': (doc)->
#        updateCartridge(doc)
#        #updatePlace(doc)
#    'removed': (doc)->
#        updateCartridge(doc)
#        updatePlace(doc)

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
                    item.lastEditor = userId
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
                    modifier['$set'].lastEditor = userId
                    return true
        return false

    remove: (userId, items) ->
        if userId != null
            user = Meteor.users.findOne {'_id': userId}
            if user != undefined and user.group == 'admin'
                return true
        return false

