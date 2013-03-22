Template.placesPageT.selectedPlaceId = 0

Template.placesPageT.places = ()->
  return Places.find {}

Template.placesPageT.stateStyle = ()->
  lastEvent = Events.findOne { placeId: this._id }, {'sort': {'date': -1, 'lastChanges': -1}}
  return "eventType" + lastEvent.typeId if lastEvent

Template.placesPageT.placeSelectedClass = ()->
  return "active" if this._id == Template.placesPageT.selectedPlaceId
  return ""

Template.placesPageT.rendered = () ->
  $('a[rel="tooltip"]').tooltip {placement: 'right'}
  if $('#placeBox').html() == ""
    $('#placeBox').html Meteor.render -> Template.curPlace()

Template.placesPageT.events
  'click #placesList a.place': ()->
    $("#placesList li.active").removeClass 'active'
    $("#" + this._id).parent().addClass 'active'
    Template.placesPageT.selectedPlaceId = this._id
    $('#placeBox').html Meteor.render -> Template.curPlace()

  'click #addPlace': ()->
    console.log 111
    Template.newPlace.placeId = null
    Template.newPlace.placeName = null
    Template.newPlace.placeDescr = null
    $('#windowBox').html Meteor.render ()-> Template.newPlace()