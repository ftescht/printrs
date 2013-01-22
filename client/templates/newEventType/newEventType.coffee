Meteor.startup ()->
    $('#addEventTypeWindow').on 'hidden', ()->
        $("#eventTypeId").val("")
        $("#newEventTypeName").val("")
        $("#newEventTypeDescr").val("")
        $("#newEventTypeColor").val("")

Template.newEventType.events
    'click button.yes': () ->
        eventTypeName = $("#newEventTypeName").val()
        if eventTypeName.length <= 3
            alertBox "newEventTypeAlertBox", "Name can't be blank"
            return null

        eventTypeColor = $("#newEventTypeColor").val()
        if eventTypeColor.length < 3
            alertBox "newEventTypeAlertBox", "Color can't be blank"
            return null
            
        eventTypeDescr = $("#newEventTypeDescr").val()

        if $("#eventTypeId").val() != ""
            selector =
                _id: $("#eventTypeId").val()
            modifier =
                $set:
                    name: eventTypeName
                    descr: eventTypeDescr
                    color: eventTypeColor
            EventTypes.update selector, modifier
        else
            EventTypes.insert
                name: eventTypeName
                descr: eventTypeDescr
                color: eventTypeColor
        $('#addEventTypeWindow').modal('hide')