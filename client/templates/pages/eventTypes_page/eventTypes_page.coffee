Template.eventTypes_page.eventTypes = ()->
  return EventTypes.find {}

Template.eventTypes_page.colorStyle = ()->
  return  "eventType" + this._id

Template.eventTypes_page.canDel = () ->
  return Events.find({typeId: this._id}).count() == 0

Template.eventTypes_page.events
  'click #eventTypes_page_eventTypeAdd': ()->
    Template.eventType_window.typeId = null
    Template.eventType_window.typeName = null
    Template.eventType_window.typeDescr = null
    Template.eventType_window.typeColor = null
    $('#windowBox').html Meteor.render ()-> Template.eventType_window()

  'click .eventTypes_page_eventTypeEdit': ()->
    Template.eventType_window.typeId = this._id
    Template.eventType_window.typeName = this.name
    Template.eventType_window.typeDescr = this.descr
    Template.eventType_window.typeColor = this.color
    $('#windowBox').html Meteor.render ()-> Template.eventType_window()

  'click .eventTypes_page_eventTypeRemove': () ->
    EventTypes.remove
      _id: this._id
    return false
