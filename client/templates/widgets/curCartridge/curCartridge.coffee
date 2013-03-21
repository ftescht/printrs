Template.curCartridge.cartridge = ()->
    return Cartridges.findOne { _id: $("#cartridgesList li.active a").attr('id') }

Template.curCartridge.eventsList = ()->
    if Template.curCartridge.cartridge()
        Events.find {cartridgeId: Template.curCartridge.cartridge()._id}, {sort: {date: -1, lastChanges: -1}}

Template.curCartridge.isVisible = ()->
    return Template.curCartridge.cartridge()

Template.curCartridge.canDel = () ->
    curId = Template.curCartridge.cartridge()._id
    return Events.find({cartridgeId: curId}).count() == 0

Template.curCartridge.eventDate = ()->
    date = new Date (this.date)
    return date.format("dd.mm.yyyy")

Template.curCartridge.eventName = ()->
    return type.name if type = EventTypes.findOne({ _id: this.typeId })
    return ""

Template.curCartridge.placeName = ()->
    return palce.name if palce = Places.findOne({ _id: this.placeId })
    return ""

Template.curCartridge.eventColor = ()->
    return "eventType" + this.typeId

Template.curCartridge.events
    'click a.place': ()->
        $('#showPlaceWindow_placeId').val this.placeId
        $('#showPlaceWindow').modal 'show'
        return false

    'click button.editCurCartridge': ()->
        return null if !Template.curCartridge.cartridge()
        $('#addCartridgeWindow_id').val Template.curCartridge.cartridge()._id
        $('#addCartridgeWindow_name').val Template.curCartridge.cartridge().name
        $('#addCartridgeWindow_descr').val Template.curCartridge.cartridge().descr
        $('#addCartridgeWindow').modal 'show'

    'click #removeCurCartridge': () ->
        return null if !Template.curCartridge.cartridge()
        Cartridges.remove
            _id: Template.curCartridge.cartridge()._id
        $("#cartridgeBox").html null

    'click button.addEvent': ()->
        return null if !Template.curCartridge.cartridge()
        $('#addEventWindow_cartridgeId').val Template.curCartridge.cartridge()._id
        $('#addEventWindow').modal 'show'

    'click button.editEvent': ()->
        return null if !Template.curCartridge.cartridge()
        $('#addEventWindow_id').val this._id
        $('#addEventWindow_cartridgeId').val Template.curCartridge.cartridge()._id
        $('#addEventWindow_eventTypeId').val this.typeId
        $('#addEventWindow_placeId').val this.placeId
        date = new Date (this.date)
        if isNaN(date.getTime())
            $('#addEventWindow_date').val this.date
        else
            $('#addEventWindow_date').val date.format("dd.mm.yyyy")
        $('#addEventWindow_comment').val this.comment
        $('#addEventWindow').modal 'show'

    'click a.removeEvent': () ->
        Events.remove
            _id: this._id
        return false