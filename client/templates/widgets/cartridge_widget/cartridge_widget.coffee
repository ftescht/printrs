Template.cartridge_widget.cartridge = ()->
  return Cartridges.findOne { _id: Template.cartridges_page.selectedCartridgeId }

Template.cartridge_widget.eventsList = ()->
  if Template.cartridge_widget.cartridge()
    Events.find { cartridgeId: Template.cartridges_page.selectedCartridgeId }, {sort: {date: -1, lastChanges: -1}}

Template.cartridge_widget.isVisible = ()->
  if Template.cartridge_widget.cartridge()
    return true
  return false

Template.cartridge_widget.canDel = () ->
  if Template.cartridge_widget.cartridge()
    curId = Template.cartridges_page.selectedCartridgeId
    return Events.find({cartridgeId: curId}).count() == 0
  return false

Template.cartridge_widget.eventDate = ()->
  date = new Date (this.date)
  return date.format("dd.mm.yyyy")

Template.cartridge_widget.eventName = ()->
  return type.name if type = EventTypes.findOne({ _id: this.typeId })
  return ""

Template.cartridge_widget.placeName = ()->
  return palce.name if palce = Places.findOne({ _id: this.placeId })
  return ""

Template.cartridge_widget.eventColor = ()->
  return "eventType" + this.typeId

Template.cartridge_widget.events
  'click .cartridge_widget_placeShow': ()->
    Template.place_events_window.placeId = this.placeId
    $('#windowBox').html Meteor.render ()-> Template.place_events_window()
    return false

  'click #cartridge_widget_cartridgeEdit': ()->
    if Template.cartridge_widget.cartridge()
      Template.cartridge_window.cartridgeId = Template.cartridges_page.selectedCartridgeId
      Template.cartridge_window.cartridgeName = Template.cartridge_widget.cartridge().name
      Template.cartridge_window.cartridgeDescr = Template.cartridge_widget.cartridge().descr
      $('#windowBox').html Meteor.render ()-> Template.cartridge_window()

  'click #cartridge_widget_cartridgeRemove': () ->
    if Template.cartridge_widget.cartridge()
      Cartridges.remove
        _id: Template.cartridges_page.selectedCartridgeId
      $("#cartridgeBox").html null

  'click #cartridge_widget_eventAdd': ()->
    if Template.cartridge_widget.cartridge()
      Template.event_window.eventId = null
      Template.event_window.cartridgeId = Template.cartridges_page.selectedCartridgeId
      Template.event_window.typeId = null
      Template.event_window.placeId = null
      Template.event_window.date = null
      Template.event_window.comment = null
      $('#windowBox').html Meteor.render ()-> Template.event_window()

  'click .cartridge_widget_eventEdit': ()->
    Template.event_window.eventId = this._id
    Template.event_window.cartridgeId = this.cartridgeId
    Template.event_window.typeId = this.typeId
    Template.event_window.placeId = this.placeId
    Template.event_window.date = this.date
    Template.event_window.comment = this.comment
    $('#windowBox').html Meteor.render ()-> Template.event_window()

  'click .cartridge_widget_eventRemove': () ->
    Events.remove
      _id: this._id
    return false