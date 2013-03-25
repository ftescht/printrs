Template.user_widget.user = ()->
  return Meteor.users.findOne { _id: Template.users_page.selectedUserId }

Template.user_widget.eventsList = ()->
  if Template.user_widget.user()
    return Events.find {lastEditor: Template.users_page.selectedUserId}, {sort:
      {date: -1, lastChanges: -1}}
  return null

Template.user_widget.isVisible = ()->
  if Template.user_widget.user()
    return true
  return false

Template.user_widget.canDel = () ->
  if Template.user_widget.user()
    curId = Template.users_page.selectedUserId
    return Template.user_widget.user().group != 'admin' && Events.find({owner: curId}).count() == 0
  return false

Template.user_widget.eventDate = ()->
  date = new Date (this.date)
  return date.format("dd.mm.yyyy")

Template.user_widget.eventName = ()->
  return type.name if type = EventTypes.findOne({ _id: this.typeId })
  return ""

Template.user_widget.cartridgeName = ()->
  return cartridge.name if cartridge = Cartridges.findOne({ _id: this.cartridgeId })
  return ""

Template.user_widget.placeName = ()->
  return place.name if place = Places.findOne({ _id: this.placeId })
  return ""

Template.user_widget.eventColor = ()->
  return "eventType" + this.typeId

Template.user_widget.events
  'click #user_widget_userRemove': () ->
    if Template.user_widget.user()
      Meteor.users.remove
        _id: Template.users_page.selectedUserId
      $("#userBox").html null

  'click .user_widget_eventEdit': ()->
    Template.event_window.eventId = this._id
    Template.event_window.cartridgeId = this.cartridgeId
    Template.event_window.typeId = this.typeId
    Template.event_window.placeId = this.placeId
    Template.event_window.date = this.date
    Template.event_window.comment = this.comment
    $('#windowBox').html Meteor.render ()-> Template.event_window()

  'click .user_widget_eventRemove': () ->
    Events.remove
      _id: this._id
    return false