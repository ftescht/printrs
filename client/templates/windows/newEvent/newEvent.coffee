Template.newEvent.rendered = ()->
    $('#addEventWindow').on 'show', ()->
        if $('#addEventWindow_date').val() == ""
            $('#addEventWindow_date').val new Date().format("dd.mm.yyyy")

        $('#addEventWindow_date').datepicker
            format: "dd.mm.yyyy"
            weekStart: 1

        $('#addEventWindow_date').datepicker().on 'changeDate', (e)->
            $('#addEventWindow_date').datepicker 'hide'
            $('#addEventWindow_date').val $.format.date e.date, "dd.MM.yyyy"

        $('#addEventWindow_dateIcon').click ()->
            $('#addEventWindow_date').datepicker 'show'

    $('#addEventWindow').on 'hide', ()->
        $('#addEventWindow_id').val null
        $('#addEventWindow_eventTypeId').val null
        $('#addEventWindow_cartridgeId').val null
        $('#addEventWindow_placeId').val null
        $('#addEventWindow_comment').val null
        $('#addEventWindow_date').val null
        if $('div.datepicker.dropdown-menu:visible').length > 0
            $('#addEventWindow_date').datepicker 'hide'

Template.newEvent.eventTypes = ()->
    return EventTypes.find()

Template.newEvent.places = ()->
    return Places.find()

Template.newEvent.events
    'keydown #addEventWindow input': (e) ->
        if e.which == 13
            addEvent()
    'click #addEventWindow button.yes': () ->
        addEvent()

addEvent = ()->
    eventCartridgeId = 0
    eventCartridgeId = $('#addEventWindow_cartridgeId').val()

    eventTypeId = 0
    eventTypeId = $('#addEventWindow_eventTypeId').val()

    placeId = 0
    placeId = $('#addEventWindow_placeId').val()

    eventComment = $('#addEventWindow_comment').val()

    eventDate = null
    dateArr = $('#addEventWindow_date').val().match(/^(\d{1,2}).(\d{1,2}).(\d{4})$/)
    if dateArr
        eventDate = new Date (dateArr[2] + "/" + dateArr[1] + "/" + dateArr[3])

    error = "<ul>"
    if eventCartridgeId == 0
        error += "<li>Cartridge not selected</li>"
    if eventTypeId == 0
        error += "<li>Event type not selected</li>"
    if placeId == 0
        error += "<li>Place not selected</li>"
    if eventDate == null
        error += "<li>Date can't be blank</li>"
    if error != "<ul>"
        error += "</ul>"
        alertBox 'newEventAlertBox', error
        return null
        
    if $('#addEventWindow_id').val() != ""
        selector =
            _id: $('#addEventWindow_id').val()
        modifier =
            $set:
                typeId: eventTypeId
                placeId: placeId
                date: eventDate
                comment: eventComment
        Events.update selector, modifier
    else
        Events.insert
            cartridgeId: eventCartridgeId
            typeId: eventTypeId
            placeId: placeId
            date: eventDate
            comment: eventComment
    $('#addEventWindow').modal 'hide'