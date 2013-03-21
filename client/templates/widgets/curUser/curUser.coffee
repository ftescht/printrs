Template.curUser.user = ()->
    return Meteor.users.findOne { _id: $("#usersList li.active a").attr('id') }

Template.curUser.eventsList = ()->
    if Template.curUser.user()
        Events.find {lastEditor: Template.curUser.user()._id}, {sort: {date: -1, lastChanges: -1}}

Template.curUser.isVisible = ()->
    return Template.curUser.user()

Template.curUser.canDel = () ->
    curId = Template.curUser.user()._id
    return Events.find({owner: curId}).count() == 0

Template.curUser.eventDate = ()->
    date = new Date (this.date)
    return date.format("dd.mm.yyyy")

Template.curUser.eventName = ()->
    return type.name if type = EventTypes.findOne({ _id: this.typeId })
    return ""

Template.curUser.cartridgeName = ()->
    return cartridge.name if cartridge = Cartridges.findOne({ _id: this.cartridgeId })
    return ""

Template.curUser.placeName = ()->
  return place.name if place = Places.findOne({ _id: this.placeId })
  return ""

Template.curUser.eventColor = ()->
    return "eventType" + this.typeId

Template.curUser.events
    'click #removeCurUser': () ->
        return null if !Template.curUser.user()
        Meteor.users.remove
            _id: Template.curUser.user()._id
        $("#userBox").html null

    'click button.editEvent': ()->
        return null if !Template.curUser.user()
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