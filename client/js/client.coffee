
selectedCartridgeId = 0

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

    $('#addEventWindow').on 'hide', ()->
        $("#eventId").val("")
        $("#newEventComment").val("")
        $('#newEventDate').val("")
        if $("div.datepicker.dropdown-menu:visible").length > 0
            $('#newEventDate').datepicker('hide')

    $('#addCartridgeWindow').on 'hide', ()->
        $("#cartridgeId").val("")
        $("#newCartridgeName").val("")
        $("#newCartridgeDescr").val("")

alertBox = (id, text) ->
    alertHtml = '<div class="alert"><a class="close" data-dismiss="alert" href="#">&times;</a><strong>'+text+'</strong></div>'
    $("#"+id).html(alertHtml)

Template.eventTypesList.eventTypes = ()->
    return EventTypes.find({}, {sort: {id: 1}})

Template.cartridgesList.cartridges = ()->
    return Cartridges.find({}, {sort: {name: 1}})

Template.eventsList.eventName = ()->
    typeId = this.typeId
    type = _.first _.filter EventTypes.find({}).fetch(),  (item)->
        item.id - typeId == 0
    return type.name

Template.eventsList.eventColor = ()->
    rowClass = ""
    switch this.typeId
        when '1' then return "success"
        when '2' then return "error"
        when '3' then return "warning"
        when '4' then return "info"

Template.cartridgesList.stateStyle = ()->
    curCartridgeId = this._id
    if lastEvent = Events.findOne({cartridgeId: curCartridgeId}, {sort: {date: -1, lastChanges: -1}})
        switch lastEvent.typeId
            when '1' then return "greenState"
            when '2' then return "redState"
            when '3' then return "orangeState"
            when '4' then return "blueState"
    return ""

Template.cartridgesList.events
    'click a': () ->
        if selectedCartridgeId != 0
            $("#"+selectedCartridgeId).parent().removeClass("active")
        selectedCartridgeId = this._id
        $("#"+selectedCartridgeId).parent().addClass("active")
        $("#eventsPlace").html Meteor.render ->
            Template.eventsList
                eventsList: Events.find({cartridgeId: selectedCartridgeId}, {sort: {date: -1, lastChanges: -1}})
        $("#cartridgeBox").html Meteor.render ->
            Template.curCartridge
                cartridge: Cartridges.findOne({_id: selectedCartridgeId})

Template.eventsList.events
    'click button.editEvent': ()->
        $('#addEventWindow').modal('show')
        $("#eventId").val this._id
        $("#newEventTypeId").val this.typeId
        $("#newEventDate").val this.date
        $("#newEventComment").val this.comment
    'click a.removeEvent': () ->
        Events.remove
            _id: this._id

Template.curCartridge.events
    'click a.editCurCartridge': ()->
        $('#addCartridgeWindow').modal('show')
        $("#cartridgeId").val this.cartridge._id
        $("#newCartridgeName").val this.cartridge.name
        $("#newCartridgeDescr").val this.cartridge.descr
    'click #removeCurCartridge': () ->
        Events.remove
            cartridgeId: selectedCartridgeId
        Cartridges.remove
            _id: selectedCartridgeId
        selectedCartridgeId = 0
        $("#cartridgeBox").html ""

Template.newCartridge.events
    'click button.yes': () ->
        cartridgeName = $("#newCartridgeName").val()
        if cartridgeName.length < 3
            alertBox "newCartridgeAlertBox", "Name can't be blank"
            return null
        cartridgeDescr = $("#newCartridgeDescr").val()

        if $("#cartridgeId").val() != ""
            selector =
                _id: $("#cartridgeId").val()
            modifier =
                $set:
                    lastChanges: new Date()
                    name: cartridgeName
                    descr: cartridgeDescr
            Cartridges.update selector, modifier
        else
            Cartridges.insert
                creationDate: new Date()
                lastChanges: new Date()
                name: cartridgeName
                descr: cartridgeDescr
        $('#addCartridgeWindow').modal('hide')

Template.newEvent.events
    'click button.yes': () ->
        eventCartridgeId = selectedCartridgeId
        eventTypeId = 0
        eventTypeId = $("#newEventTypeId").val()
        eventDate = $("#newEventDate").val()
        eventComment = $("#newEventComment").val()

        error = "<ul>"
        if selectedCartridgeId == 0
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
                    lastChanges: new Date()
                    typeId: eventTypeId
                    date: eventDate
                    comment: eventComment
            Events.update selector, modifier
        else
            Events.insert
                creationDate: new Date()
                lastChanges: new Date()
                cartridgeId: eventCartridgeId
                typeId: eventTypeId
                date: eventDate
                comment: eventComment
        $('#addEventWindow').modal('hide')