Template.curCartridge.cartridge = ()->
  return Cartridges.findOne { _id: Template.cartridgesPageT.selectedCartridgeId }

Template.curCartridge.eventsList = ()->
  if Template.curCartridge.cartridge()
    Events.find { cartridgeId: Template.cartridgesPageT.selectedCartridgeId }, {sort: {date: -1, lastChanges: -1}}

Template.curCartridge.isVisible = ()->
  if Template.curCartridge.cartridge()
    return true
  return false

Template.curCartridge.canDel = () ->
  if Template.curCartridge.cartridge()
    curId = Template.cartridgesPageT.selectedCartridgeId
    return Events.find({cartridgeId: curId}).count() == 0
  return false

Template.curCartridge.eventDate = ()->
  date = new Date (this.date)
  return date.format("dd.mm.yyyy")

Template.curCartridge.eventName = ()->
  return type.name if type = EventTypes.findOne({ _id: this.typeId })
  return ""

Template.curCartridge.placeName = ()->
  return palce.name if palce = Places.findOne({ _id: this.placeId })
  return ""

Template.curCartridge.eventColor = ()->
  return "eventType" + this.typeId

Template.curCartridge.events
  'click a.place': ()->
    Template.place.placeId = this.placeId
    $('#windowBox').html Meteor.render ()-> Template.place()
    return false

  'click #editCartridge': ()->
    if Template.curCartridge.cartridge()
      Template.newCartridge.cartridgeId = Template.cartridgesPageT.selectedCartridgeId
      Template.newCartridge.cartridgeName = Template.curCartridge.cartridge().name
      Template.newCartridge.cartridgeDescr = Template.curCartridge.cartridge().descr
      $('#windowBox').html Meteor.render ()-> Template.newCartridge()

  'click #removeCurCartridge': () ->
    if Template.curCartridge.cartridge()
      Cartridges.remove
        _id: Template.cartridgesPageT.selectedCartridgeId
      $("#cartridgeBox").html null

  'click #addEvent': ()->
    if Template.curCartridge.cartridge()
      Template.newEvent.eventId = null
      Template.newEvent.cartridgeId = Template.cartridgesPageT.selectedCartridgeId
      Template.newEvent.typeId = null
      Template.newEvent.placeId = null
      Template.newEvent.date = null
      Template.newEvent.comment = null
      $('#windowBox').html Meteor.render ()-> Template.newEvent()

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