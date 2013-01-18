Template.curCartridge.cartridge = ()->
    Cartridges.findOne({_id: Template.cartridgesList.selectedCartridgeId})

Template.curCartridge.eventsList = ()->
    if Template.curCartridge.cartridge()
        Events.find({cartridgeId: Template.curCartridge.cartridge()._id}, {sort: {date: -1, lastChanges: -1}})

Template.curCartridge.isVisible = ()->
    return Template.curCartridge.cartridge() != undefined

Template.curCartridge.eventName = ()->
    typeId = this.typeId
    type = _.first _.filter EventTypes.find({}).fetch(),  (item)->
        item.id - typeId == 0
    return type.name

Template.curCartridge.eventColor = ()->
    rowClass = ""
    switch this.typeId
        when '1' then return "success"
        when '2' then return "error"
        when '3' then return "warning"
        when '4' then return "info"

Template.curCartridge.events
    'click a.editCurCartridge': ()->
        $('#addCartridgeWindow').modal('show')
        $("#cartridgeId").val Template.curCartridge.cartridge()._id
        $("#newCartridgeName").val Template.curCartridge.cartridge().name
        $("#newCartridgeDescr").val Template.curCartridge.cartridge().descr

    'click #removeCurCartridge': () ->
        Events.remove
            cartridgeId: Template.curCartridge.cartridge()._id
        Cartridges.remove
            _id: Template.curCartridge.cartridge()._id
        Template.cartridgesList.selectedCartridgeId = 0
        $("#cartridgeBox").html ""

    'click button.editEvent': ()->
        $('#addEventWindow').modal('show')
        $("#eventId").val this._id
        $("#newEventTypeId").val this.typeId
        $("#newEventDate").val this.date
        $("#newEventComment").val this.comment

    'click a.removeEvent': () ->
        Events.remove
            _id: this._id