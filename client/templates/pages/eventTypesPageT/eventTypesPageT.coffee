Template.eventTypesPageT.eventTypes = ()->
  return EventTypes.find {}

Template.eventTypesPageT.colorStyle = ()->
  return  "eventType" + this._id

Template.eventTypesPageT.canDel = () ->
  return Events.find({typeId: this._id}).count() == 0

Template.eventTypesPageT.events
  'click #addEventType': ()->
    Template.newEventType.typeId = null
    Template.newEventType.typeName = null
    Template.newEventType.typeDescr = null
    Template.newEventType.typeColor = null
    $('#windowBox').html Meteor.render ()-> Template.newEventType()

  'click button.editEventType': ()->
    Template.newEventType.typeId = this._id
    Template.newEventType.typeName = this.name
    Template.newEventType.typeDescr = this.descr
    Template.newEventType.typeColor = this.color
    $('#windowBox').html Meteor.render ()-> Template.newEventType()

  'click a.removeEventType': () ->
    EventTypes.remove
      _id: this._id
    return false
