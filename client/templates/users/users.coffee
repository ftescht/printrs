Template.users.users = ()->
    return Meteor.users.find()

Template.users.usergroup = ()->
    return this.group

Template.users.events
    'click a.removeUser': () ->
        Meteor.users.remove
            _id: this._id