Places = new Meteor.Collection 'places'

Meteor.publish 'all-places', ()->
    user = Meteor.users.findOne {'_id': this.userId}
    if user != undefined and user.group == 'admin'
        return Places.find()
    return null

checkNewPlaceModel = (item) ->
    err =  Object.keys(item).length == 3
    err &= item.name.length > 3
    err &= item.descr != undefined
    return err

checkUpdatePlaceModel = (items, fields, modifier) ->
    err = true
    err &= fields[0] == 'name'
    err &= fields[1] == 'descr'
    err &= Object.keys(modifier['$set']).length == 2
    err &= modifier['$set'].name.length > 3
    err &= modifier['$set'].descr != undefined
    return err

Places.allow
    insert: (userId, item) ->
        if userId != null
            user = Meteor.users.findOne {'_id': userId}
            if user != undefined and user.group == 'admin'
                if checkNewPlaceModel item
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
                if checkUpdatePlaceModel items, fields, modifier
                    now = new Date()
                    fields.push 'lastChanges'
                    modifier['$set'].lastChanges = now
                    modifier['$set'].lastEditor = userId
                    return true
        return false

    remove: (userId, item) ->
        if userId != null
            user = Meteor.users.findOne {'_id': userId}
            if user != undefined and user.group == 'admin'
                if Events.find({placeId: item.id}).count() == 0
                    return true
        return false