Meteor.publish 'all-users', ()->
    user = Meteor.users.findOne {'_id': this.userId}
    if user != undefined and user.group == 'admin'
        return Meteor.users.find()
    return null

Meteor.users.allow
    insert: (userId, item) ->
        if userId
            user = Meteor.users.findOne {'_id': userId}
            if user != undefined and user.group == 'admin'
                return true
        return false

    update: (userId, items, fields, modifier) ->
        if userId
            user = Meteor.users.findOne {'_id': userId}
            if user != undefined and user.group == 'admin'
                return true
        return false

    remove: (userId, removeItem) ->
        if userId
            user = Meteor.users.findOne {'_id': userId}
            if user != undefined and user.group == 'admin'
                if userId == removeItem._id or removeItem.group == 'admin'
                    console.log "can't remove admin"
                    return false
                return true
        return false