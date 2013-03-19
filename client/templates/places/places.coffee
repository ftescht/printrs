Template.places.places = ()->
    return Places.find {}

Template.places.canDel = () ->
    curId = this._id
    return Events.find({placeId: curId}).count() == 0

Template.places.events
    'click a.removePlace': () ->
        Places.remove
            _id: this._id

    'click button.editPlace': ()->
        $('#addPlaceWindow').modal 'show'
        $('#placeId').val this._id
        $('#newPlaceName').val this.name
        $('#newPlaceDescr').val this.descr
