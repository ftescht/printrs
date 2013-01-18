Meteor.startup ()->
    $('#addEventWindow').on 'shown', ()->
        if $('#newEventDate').val() == ""
            $('#newEventDate').val $.format.date(new Date(), "dd.MM.yyyy")

        $('#newEventDate').datepicker
            format: "dd.mm.yyyy"
            weekStart: 1

        $('#newEventDate').datepicker().on 'changeDate', (e)->
            $('#newEventDate').datepicker('hide')
            $('#newEventDate').val $.format.date(e.date, "dd.MM.yyyy")

        $('#newEventDateIcon').click ()->
            $('#newEventDate').datepicker('show')

    $('#addEventWindow').on 'hidden', ()->
        $("#eventId").val("")
        $("#newEventComment").val("")
        $('#newEventDate').val("")
        if $("div.datepicker.dropdown-menu:visible").length > 0
            $('#newEventDate').datepicker('hide')

Template.newEvent.eventTypes = ()->
    return EventTypes.find({}, {sort: {id: 1}})

Template.newEvent.events
    'click button.yes': () ->
        eventCartridgeId = Template.cartridgesList.selectedCartridgeId
        eventTypeId = 0
        eventTypeId = $("#newEventTypeId").val()
        eventDate = $("#newEventDate").val()
        eventComment = $("#newEventComment").val()

        error = "<ul>"
        if Template.cartridgesList.selectedCartridgeId == 0
            error += "<li>Cartridge not selected</li>"
        if eventTypeId == 0
            error += "<li>Event type not selected</li>"
        if eventDate.length == 0
            error += "<li>Date can't be blank</li>"
        if error != "<ul>"
            error += "</ul>"
            alertBox "newEventAlertBox", error
            return null

        if $("#eventId").val() != ""
            selector =
                _id: $("#eventId").val()
            modifier =
                $set:
                    typeId: eventTypeId
                    date: eventDate
                    comment: eventComment
            Events.update selector, modifier
        else
            Events.insert
                cartridgeId: eventCartridgeId
                typeId: eventTypeId
                date: eventDate
                comment: eventComment
        $('#addEventWindow').modal('hide')