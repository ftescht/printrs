Template.curPlace.place = ()->
    return Places.findOne { _id: $("#placesList li.active a").attr('id') }

Template.curPlace.eventsList = ()->
    if Template.curPlace.place()
        Events.find {placeId: Template.curPlace.place()._id}, {sort: {date: -1, lastChanges: -1}}

Template.curPlace.isVisible = ()->
    return Template.curPlace.place()

Template.curPlace.canDel = () ->
    curId = Template.curPlace.place()._id
    return Events.find({placeId: curId}).count() == 0

Template.curPlace.eventDate = ()->
    date = new Date (this.date)
    return date.format("dd.mm.yyyy")

Template.curPlace.eventName = ()->
    return type.name if type = EventTypes.findOne({ _id: this.typeId })
    return ""

Template.curPlace.cartridgeName = ()->
    return cartridge.name if cartridge = Cartridges.findOne({ _id: this.cartridgeId })
    return ""

Template.curPlace.eventColor = ()->
    return "eventType" + this.typeId

Template.curPlace.events
    'click button.editCurPlace': ()->
        return null if !Template.curPlace.place()
        $('#addPlaceWindow_id').val Template.curPlace.place()._id
        $('#addPlaceWindow_name').val Template.curPlace.place().name
        $('#addPlaceWindow_descr').val Template.curPlace.place().descr
        $('#addPlaceWindow').modal 'show'

    'click #removeCurPlace': () ->
        return null if !Template.curPlace.place()
        Places.remove
            _id: Template.curPlace.place()._id
        $("#placeBox").html null

    'click button.editEvent': ()->
        return null if !Template.curPlace.place()
        $('#addEventWindow_id').val this._id
        $('#addEventWindow_cartridgeId').val this.cartridgeId
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