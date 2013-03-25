Template.place_widget.place = ()->
  return Places.findOne { _id: Template.places_page.selectedPlaceId }

Template.place_widget.eventsList = ()->
  if Template.place_widget.place()
    Events.find {placeId: Template.places_page.selectedPlaceId}, {sort: {date: -1, lastChanges: -1}}

Template.place_widget.isVisible = ()->
  if Template.place_widget.place()
    return true
  return false

Template.place_widget.canDel = () ->
  if Template.place_widget.place()
    curId = Template.places_page.selectedPlaceId
    return Events.find({placeId: curId}).count() == 0
  return false

Template.place_widget.eventDate = ()->
  date = new Date (this.date)
  return date.format("dd.mm.yyyy")

Template.place_widget.eventName = ()->
  return type.name if type = EventTypes.findOne({ _id: this.typeId })
  return ""

Template.place_widget.cartridgeName = ()->
  return cartridge.name if cartridge = Cartridges.findOne({ _id: this.cartridgeId })
  return ""

Template.place_widget.eventColor = ()->
  return "eventType" + this.typeId

Template.place_widget.events
  'click #place_widget_placeEdit': ()->
    if Template.place_widget.place()
      Template.place_window.placeId = Template.places_page.selectedPlaceId
      Template.place_window.placeName = Template.place_widget.place().name
      Template.place_window.placeDescr = Template.place_widget.place().descr
      $('#windowBox').html Meteor.render ()-> Template.place_window()

  'click #place_widget_placeRemove': () ->
    if Template.place_widget.place()
      Places.remove
        _id: Template.places_page.selectedPlaceId
      $("#placeBox").html null

  'click #place_widget_eventAdd': ()->
    if Template.place_widget.place()
      Template.event_window.eventId = null
      Template.event_window.cartridgeId = null
      Template.event_window.typeId = null
      Template.event_window.placeId = Template.places_page.selectedPlaceId
      Template.event_window.date = null
      Template.event_window.comment = null
      $('#windowBox').html Meteor.render ()-> Template.event_window()

  'click .place_widget_eventEdit': ()->
    Template.event_window.eventId = this._id
    Template.event_window.cartridgeId = this.cartridgeId
    Template.event_window.typeId = this.typeId
    Template.event_window.placeId = this.placeId
    Template.event_window.date = this.date
    Template.event_window.comment = this.comment
    $('#windowBox').html Meteor.render ()-> Template.event_window()

  'click .place_widget_eventRemove': () ->
    Events.remove
      _id: this._id
    return false