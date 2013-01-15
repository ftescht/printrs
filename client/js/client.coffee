
selectedCartridgeId = 0

Meteor.startup ()->
    $('#addEventWindow').on 'shown', ()->
        $('#newEventDate').datepicker()

alertBox = (id, text) ->
    alertHtml = '<div class="alert"><a class="close" data-dismiss="alert" href="#">&times;</a><strong>'+text+'</strong></div>'
    $("#"+id).html(alertHtml)

Template.eventTypesList.eventTypes = ()->
    return EventTypes.find({})

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

Template.cartridgesList.events
    'click a': () ->
        if selectedCartridgeId != 0
            $("#"+selectedCartridgeId).parent().removeClass("active")
        selectedCartridgeId = this._id
        $("#"+selectedCartridgeId).parent().addClass("active")
        $("#eventsPlace").html Meteor.render ->
            Template.eventsList
                eventsList: Events.find({cartridgeId: selectedCartridgeId})
        $("#cartridgeBox").html Meteor.render ->
            Template.curCartridge
                cartridge: Cartridges.findOne({_id: selectedCartridgeId})

Template.eventsList.events
    'click a.yes': () ->
        console.log this
        Events.remove
            _id: this._id

Template.curCartridge.events
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
        Cartridges.insert
            name: cartridgeName
            descr: cartridgeDescr
        $("#newCartridgeName").val("")
        $("#newCartridgeDescr").val("")
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
        else
            Events.insert
                cartridgeId: eventCartridgeId
                typeId: eventTypeId
                date: eventDate
                comment: eventComment
            $("#newEventDate").val("")
            $("#newEventComment").val("")
            $('#addEventWindow').modal('hide')