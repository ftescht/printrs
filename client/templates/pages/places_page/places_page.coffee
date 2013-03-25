Template.places_page.selectedPlaceId = 0

Template.places_page.places = ()->
  return Places.find {}

Template.places_page.stateStyle = ()->
  lastEvent = Events.findOne { placeId: this._id }, {'sort': {'date': -1, 'lastChanges': -1}}
  return "eventType" + lastEvent.typeId if lastEvent

Template.places_page.placeSelectedClass = ()->
  return "active" if this._id == Template.places_page.selectedPlaceId
  return ""

Template.places_page.rendered = () ->
  $('a[rel="tooltip"]').tooltip {placement: 'right'}
  if $('#placeBox').html() == ""
    $('#placeBox').html Meteor.render -> Template.place_widget()

Template.places_page.events
  'click .places_page_place': ()->
    $("#places_page_placesList li.active").removeClass 'active'
    $("#" + this._id).parent().addClass 'active'
    Template.places_page.selectedPlaceId = this._id
    $('#placeBox').html Meteor.render -> Template.place_widget()

  'click #places_page_placeAdd': ()->
    Template.place_window.placeId = null
    Template.place_window.placeName = null
    Template.place_window.placeDescr = null
    $('#windowBox').html Meteor.render ()-> Template.place_window()
