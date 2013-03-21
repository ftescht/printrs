Meteor.startup ()->
    $('#addPlaceWindow').on 'hidden', ()->
        $('#placeId').val null
        $('#newPlaceName').val null
        $('#newPlaceDescr').val null

Template.newPlace.events
    'keydown #addPlaceWindow input': (e) ->
        if e.which == 13
            addPlace()
    'click #addPlaceWindow button.yes': () ->
        addPlace()
        
addPlace = () ->
    placeName = $('#newPlaceName').val()
    if placeName.length <= 3
        alertBox 'newPlaceAlertBox', "Name can't be blank"
        return null

    placeDescr = $('#newPlaceDescr').val()

    if $('#placeId').val() != ""
        selector =
            _id: $('#placeId').val()
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