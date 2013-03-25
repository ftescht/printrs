Template.place_window.rendered = ()->
  $('#place_window').modal 'show'

  $('#place_window').on 'shown', ()->
    $('#place_window_title').text "Edit Place" if Template.place_window.placeId
    $('#place_window_name').val Template.place_window.placeName if Template.place_window.placeName
    $('#place_window_descr').val Template.place_window.placeDescr if Template.place_window.placeDescr

Template.place_window.placeId = null
Template.place_window.placeName = null
Template.place_window.placeDescr = null

Template.place_window.events
  'keydown #place_window input': (e)->
    addPlace() if e.which == 13
  'click #place_window_save': ()->
    addPlace()

addPlace = ()->
  placeId = Template.place_window.placeId if Template.place_window.placeId
  placeName = $('#place_window_name').val()
  placeDescr = $('#place_window_descr').val()

  if placeName.length <= 3
    alertBox 'place_window_alert', "Name can't be blank"
    return null

  if placeId
    selector =
      _id: placeId
    modifier =
      $set:
        name: placeName
        descr: placeDescr
    Places.update selector, modifier
  else
    Places.insert
      name: placeName
      descr: placeDescr
  $('#place_window').modal 'hide'