Template.eventTypesPageT.eventTypes = ()->
    return EventTypes.find {}

Template.eventTypesPageT.colorStyle = ()->
    return  "eventType" + this._id

Template.eventTypesPageT.canDel = () ->
    return Events.find({typeId: this._id}).count() == 0

Template.eventTypesPageT.events
    'click a.removeEventType': () ->
        EventTypes.remove
            _id: this._id
        return false

    'click button.editEventType': ()->
        $('#addEventTypeWindow_id').val this._id
        $('#addEventTypeWindow_name').val this.name
        $('#addEventTypeWindow_descr').val this.descr
        $('#addEventTypeWindow_color').val this.color
        $('#addEventTypeWindow').modal 'show'
