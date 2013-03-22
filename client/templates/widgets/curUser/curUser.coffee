Template.curUser.user = ()->
  return Meteor.users.findOne { _id: Template.usersPageT.selectedUserId }

Template.curUser.eventsList = ()->
  if Template.curUser.user()
    return Events.find {lastEditor: Template.usersPageT.selectedUserId}, {sort:
      {date: -1, lastChanges: -1}}
  return null

Template.curUser.isVisible = ()->
  if Template.curUser.user()
    return true
  return false

Template.curUser.canDel = () ->
  if Template.curUser.user()
    curId = Template.usersPageT.selectedUserId
    return Template.curUser.user().group != 'admin' && Events.find({owner: curId}).count() == 0
  return false

Template.curUser.eventDate = ()->
  date = new Date (this.date)
  return date.format("dd.mm.yyyy")

Template.curUser.eventName = ()->
  return type.name if type = EventTypes.findOne({ _id: this.typeId })
  return ""

Template.curUser.cartridgeName = ()->
  return cartridge.name if cartridge = Cartridges.findOne({ _id: this.cartridgeId })
  return ""

Template.curUser.placeName = ()->
  return place.name if place = Places.findOne({ _id: this.placeId })
  return ""

Template.curUser.eventColor = ()->
  return "eventType" + this.typeId

Template.curUser.events
  'click #removeCurUser': () ->
    if Template.curUser.user()
      Meteor.users.remove
        _id: Template.usersPageT.selectedUserId
      $("#userBox").html null

  'click button.editEvent': ()->
    Template.newEvent.eventId = this._id
    Template.newEvent.cartridgeId = this.cartridgeId
    Template.newEvent.typeId = this.typeId
    Template.newEvent.placeId = this.placeId
    Template.newEvent.date = this.date
    Template.newEvent.comment = this.comment
    $('#windowBox').html Meteor.render ()-> Template.newEvent()

  'click a.removeEvent': () ->
    Events.remove
      _id: this._id
    return false