Meteor.startup ()->
    $('#addEventTypeWindow').on 'hidden', ()->
        $('#eventTypeId').val null
        $('#newEventTypeName').val null
        $('#newEventTypeDescr').val null
        $('#newEventTypeColor').val null

Template.newEventType.eventTypes = ()->
    return EventTypes.find {}, {sort: {id: 1}}

Template.newEventType.events
    'keydown #addEventTypeWindow input': (e) ->
        if e.which == 13
            addEventType()
    'click #addEventTypeWindow button.yes': () ->
        addEventType()
        
addEventType = () ->
    eventTypeName = $('#newEventTypeName').val()
    if eventTypeName.length <= 3
        alertBox 'newEventTypeAlertBox', "Name can't be blank"
        return null

    eventTypeColor = $('#newEventTypeColor').val()
    if eventTypeColor.length < 3
        alertBox 'newEventTypeAlertBox', "Color can't be blank"
        return null
        
    eventTypeDescr = $('#newEventTypeDescr').val()

    if $('#eventTypeId').val() != ""
        selector =
            _id: $('#eventTypeId').val()
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