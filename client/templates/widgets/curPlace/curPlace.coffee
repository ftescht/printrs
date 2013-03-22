Template.curPlace.place = ()->
  return Places.findOne { _id: Template.placesPageT.selectedPlaceId }

Template.curPlace.eventsList = ()->
  if Template.curPlace.place()
    Events.find {placeId: Template.placesPageT.selectedPlaceId}, {sort: {date: -1, lastChanges: -1}}

Template.curPlace.isVisible = ()->
  if Template.curPlace.place()
    return true
  return false

Template.curPlace.canDel = () ->
  if Template.curPlace.place()
    curId = Template.placesPageT.selectedPlaceId
    return Events.find({placeId: curId}).count() == 0
  return false

Template.curPlace.eventDate = ()->
  date = new Date (this.date)
  return date.format("dd.mm.yyyy")

Template.curPlace.eventName = ()->
  return type.name if type = EventTypes.findOne({ _id: this.typeId })
  return ""

Template.curPlace.cartridgeName = ()->
  return cartridge.name if cartridge = Cartridges.findOne({ _id: this.cartridgeId })
  return ""

Template.curPlace.eventColor = ()->
  return "eventType" + this.typeId

Template.curPlace.events
  'click #editCurPlace': ()->
    if Template.curPlace.place()
      Template.newPlace.placeId = Template.placesPageT.selectedPlaceId
      Template.newPlace.placeName = Template.curPlace.place().name
      Template.newPlace.placeDescr = Template.curPlace.place().desc
      $('#windowBox').html Meteor.render ()-> Template.newPlace()

  'click #removeCurPlace': () ->
    if Template.curPlace.place()
      Places.remove
        _id: Template.placesPageT.selectedPlaceId
      $("#placeBox").html null

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