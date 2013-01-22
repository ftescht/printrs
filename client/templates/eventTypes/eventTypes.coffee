Template.eventTypes.eventTypes = ()->
    return EventTypes.find {}

Template.eventTypes.colorStyle = ()->
    return  "eventType" + this.id

Template.eventTypes.events
    'click a.removeEventType': () ->
        EventTypes.remove
            _id: this._id

    'click button.editEventType': ()->
        $('#addEventTypeWindow').modal('show')
        $("#eventTypeId").val this._id
        $("#newEventTypeName").val this.name
        $("#newEventTypeDescr").val this.descr
        $("#newEventTypeColor").val this.color