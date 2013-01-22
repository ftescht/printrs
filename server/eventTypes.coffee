EventTypes = new Meteor.Collection "eventTypes"

Meteor.publish "all-eventtypes", ()->
    user = Meteor.users.findOne({'_id': this.userId})
    if user != undefined and user.group == 'admin'
        return EventTypes.find {}, {'sort': {'id': 1}}
    return null

checkNewEventTypeModel = (item) ->
    err =   Object.keys(item).length == 4
    err &= item.name.length > 3
    err &= item.descr != undefined
    err &= item.color.length > 3
    return err

checkUpdateEventTypeModel = (items, fields, modifier) ->
    err = items.length == 1
    err &= fields[0] == 'name'
    err &= fields[1] == 'descr'
    err &= fields[2] == 'color'
    err &= Object.keys(modifier["$set"]).length == 3
    err &= modifier["$set"].name.length > 3
    err &= modifier["$set"].descr != undefined
    err &= modifier["$set"].color.length > 3
    return err

EventTypes.allow
    insert: (userId, item) ->
        if userId != null
            user = Meteor.users.findOne {'_id': userId}
            if user != undefined and user.group == 'admin'
                id = 0
                maxET = EventTypes.findOne {}, {'sort': {'id': -1}}
                if maxET != null or maxET != undefined
                    id = maxET.id + 1
                if checkNewEventTypeModel item
                    now = new Date()
                    item.creationDate = now
                    item.lastChanges = now
                    item.owner = userId
                    item.id = id
                    return true
        return true

    update: (userId, items, fields, modifier) ->
        if userId != null
            user = Meteor.users.findOne({'_id': userId})
            if user != undefined and user.group == 'admin'
                if checkUpdateEventTypeModel items, fields, modifier
                    now = new Date()
                    fields.push "lastChanges"
                    modifier["$set"].lastChanges = now
                    return true
        return false

    remove: (userId, items) ->
        if userId != null
            user = Meteor.users.findOne({'_id': userId})
            if user != undefined and user.group == 'admin'
                curId = items[0].id+ ""
                if Events.find({typeId: curId}).count() == 0
                    return true
        return false