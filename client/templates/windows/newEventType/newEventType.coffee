Template.newEventType.rendered = ()->
    $('#addEventTypeWindow').on 'hide', ()->
        $('#addEventTypeWindow_id').val null
        $('#addEventTypeWindow_name').val null
        $('#addEventTypeWindow_descr').val null
        $('#addEventTypeWindow_color').val null

Template.newEventType.eventTypes = ()->
    return EventTypes.find {}, {sort: {id: 1}}

Template.newEventType.events
    'keydown #addEventTypeWindow input': (e) ->
        if e.which == 13
            addEventType()
    'click #addEventTypeWindow button.yes': () ->
        addEventType()
        
addEventType = () ->
    eventTypeName = $('#addEventTypeWindow_name').val()
    eventTypeColor = $('#addEventTypeWindow_color').val()
    eventTypeDescr = $('#addEventTypeWindow_descr').val()
    
    if eventTypeName.length <= 3
        alertBox 'newEventTypeAlertBox', "Name can't be blank"
        return null
    if eventTypeColor.length < 3
        alertBox 'newEventTypeAlertBox', "Color can't be blank"
        return null

    if $('#addEventTypeWindow_id').val() != ""
        selector =
            _id: $('#addEventTypeWindow_id').val()
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
    $('#addEventTypeWindow').modal 'hide'