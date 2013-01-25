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

    remove: (userId, items) ->
        if userId
            user = Meteor.users.findOne {'_id': userId}
            if user != undefined and user.group == 'admin'
                if userId == items[0]._id or items[0].group == 'admin'
                    return false
                return true
        return false