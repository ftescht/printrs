Meteor.startup ()->
    $('#addEventWindow').on 'shown', ()->
        if $('#newEventDate').val() == ""
            $('#newEventDate').val new Date().format("dd.mm.yyyy")

        $('#newEventDate').datepicker
            format: "dd.mm.yyyy"
            weekStart: 1

        $('#newEventDate').datepicker().on 'changeDate', (e)->
            $('#newEventDate').datepicker 'hide'
            $('#newEventDate').val $.format.date e.date, "dd.MM.yyyy"

        $('#newEventDateIcon').click ()->
            $('#newEventDate').datepicker 'show'

    $('#addEventWindow').on 'hidden', ()->
        $('#eventId').val null
        $('#newEventPlace').val null
        $('#newEventComment').val null
        $('#newEventDate').val null
        if $('div.datepicker.dropdown-menu:visible').length > 0
            $('#newEventDate').datepicker 'hide'

Template.newEvent.eventTypes = ()->
    return EventTypes.find {}, {sort: {id: 1}}

Template.newEvent.events
    'keydown #addEventWindow input': (e) ->
        if e.which == 13
            addEvent()
    'click #addEventWindow button.yes': () ->
        addEvent()

addEvent = ()->
    eventCartridgeId = Template.cartridgesList.selectedCartridgeId
    eventTypeId = 0
    eventTypeId = $('#newEventTypeId').val()
    eventDate = null
    eventComment = $('#newEventComment').val()
    eventPlace = $('#newEventPlace').val()

    dateArr = $('#newEventDate').val().match(/^(\d{1,2}).(\d{1,2}).(\d{4})$/)
    if dateArr
        eventDate = new Date (dateArr[2] + "/" + dateArr[1] + "/" + dateArr[3])
    error = "<ul>"
    if Template.cartridgesList.selectedCartridgeId == 0
        error += "<li>Cartridge not selected</li>"
    if eventTypeId == 0
        error += "<li>Event type not selected</li>"
    if eventDate == null
        error += "<li>Date can't be blank</li>"
    if error != "<ul>"
        error += "</ul>"
        alertBox 'newEventAlertBox', error
        return null
        
    if $('#eventId').val() != ""
        selector =
            _id: $('#eventId').val()
        modifier =
            $set:
                typeId: eventTypeId
                date: eventDate
                place: eventPlace
                comment: eventComment
        Events.update selector, modifier
    else
        Events.insert
            cartridgeId: eventCartridgeId
            typeId: eventTypeId
            date: eventDate
            place: eventPlace
            comment: eventComment
    $('#addEventWindow').modal 'hide'