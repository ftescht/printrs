Template.eventTypes.eventTypes = ()->
    return EventTypes.find {}

Template.eventTypes.colorStyle = ()->
    return  "eventType" + this._id

Template.eventTypes.canDel = () ->
    return Events.find({typeId: this._id}).count() == 0

Template.eventTypes.events
    'click a.removeEventType': () ->
        EventTypes.remove
            _id: this._id

    'click button.editEventType': ()->
        $('#addEventTypeWindow').modal 'show'
        $('#eventTypeId').val this._id
        $('#newEventTypeName').val this.name
        $('#newEventTypeDescr').val this.descr
        $('#newEventTypeColor').val this.color
