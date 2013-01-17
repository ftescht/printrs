
Accounts.config
    sendVerificationEmail: false
    forbidClientAccountCreation: false

Meteor.publish "all-users", ()->
    user = Meteor.users.findOne({'_id': this.userId})
    if user != undefined and user.group == 'admin'
        return Meteor.users.find()
    return null

Meteor.users.allow
    insert: (userId, item) ->
        if userId == null
            return false
        user = Meteor.users.findOne({'_id': userId})
        if user == undefined or user.group != 'admin'
            return false
        return true

    update: (userId, items, fields, modifier) ->
        if userId == null
            return false
        user = Meteor.users.findOne({'_id': userId})
        if user == undefined or user.group != 'admin'
            return false
        return true

    remove: (userId, items) ->
        if userId == null
            return false
        user = Meteor.users.findOne({'_id': userId})
        if user == undefined or user.group != 'admin'
            return false
        if userId == items[0]._id
            return false
        return true