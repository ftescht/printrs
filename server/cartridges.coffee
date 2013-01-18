
Cartridges = new Meteor.Collection "cartridges"

Meteor.publish "all-cartridges", ()->
    user = Meteor.users.findOne({'_id': this.userId})
    if user != undefined and user.group == 'admin'
        return Cartridges.find()
    return null

checkNewCartridgeModel = (item) ->
    err =   Object.keys(item).length == 3
    err &= item.name.length > 3
    err &= item.descr != undefined
    return err

checkUpdateCartridgeModel = (items, fields, modifier) ->
    err = items.length == 1
    err &= fields[0] == 'name'
    err &= fields[1] == 'descr'
    err &= Object.keys(modifier["$set"]).length == 2
    err &= modifier["$set"].name.length > 3
    err &= modifier["$set"].descr != undefined
    return err

Cartridges.allow
    insert: (userId, item) ->
        if userId == null
            return false
        user = Meteor.users.findOne({'_id': userId})
        if user == undefined or user.group != 'admin'
            return false
        if checkNewCartridgeModel item
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
        if checkUpdateCartridgeModel items, fields, modifier
            now = new Date()
            fields.push "lastChanges"
            modifier["$set"].lastChanges = now
            return true
        return false

    remove: (userId, items) ->
        if userId == null
            return false
        user = Meteor.users.findOne({'_id': userId})
        if user == undefined or user.group != 'admin'
            return false
        return true