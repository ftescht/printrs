Template.newPlace.rendered = ()->
    $('#addPlaceWindow').on 'hide', ()->
        $('#addPlaceWindow_id').val null
        $('#addPlaceWindow_name').val null
        $('#addPlaceWindow_descr').val null

Template.newPlace.events
    'keydown #addPlaceWindow input': (e) ->
        if e.which == 13
            addPlace()
    'click #addPlaceWindow button.yes': () ->
        addPlace()
        
addPlace = () ->
    placeName = $('#addPlaceWindow_name').val()
    placeDescr = $('#addPlaceWindow_descr').val()

    if placeName.length <= 3
        alertBox 'newPlaceAlertBox', "Name can't be blank"
        return null

    if $('#addPlaceWindow_id').val() != ""
        selector =
            _id: $('#addPlaceWindow_id').val()
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