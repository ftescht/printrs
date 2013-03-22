Template.newPlace.rendered = ()->
  $('#addPlaceWindow').modal 'show'

  $('#addPlaceWindow').on 'shown', ()->
    $('#addPlaceWindow_name').val Template.newPlace.placeName if Template.newPlace.placeName
    $('#addPlaceWindow_descr').val Template.newPlace.placeDescr if Template.newPlace.placeDescr

Template.newPlace.placeId = null
Template.newPlace.placeName = null
Template.newPlace.placeDescr = null

Template.newPlace.events
  'keydown #addPlaceWindow input': (e) ->
    addPlace() if e.which == 13
  'click #addPlaceWindow button.yes': () ->
    addPlace()

addPlace = () ->
  placeId = Template.newPlace.placeId if Template.newPlace.placeId
  placeName = $('#addPlaceWindow_name').val()
  placeDescr = $('#addPlaceWindow_descr').val()

  if placeName.length <= 3
    alertBox 'newPlaceAlertBox', "Name can't be blank"
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
  $('#addPlaceWindow').modal 'hide'