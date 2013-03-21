Template.cartridgesPageT.selectedCartridgeId =  0

Template.cartridgesPageT.cartridges = ()->
    return Cartridges.find {}, {sort: {name: 1}}

Template.cartridgesPageT.stateStyle = ()->
    lastEvent = Events.findOne { cartridgeId: this._id }, {'sort': {'date': -1, 'lastChanges': -1}}
    return "eventType" + lastEvent.typeId

Template.cartridgesPageT.cartridgeSelectedClass = ()->
    return "active" if this._id == Template.cartridgesPageT.selectedCartridgeId
    return ""

Template.cartridgesPageT.rendered = () ->
    $('a[rel="tooltip"]').tooltip {placement: 'right'}
    if $('#cartridgeBox').html() == ""
        $('#cartridgeBox').html Meteor.render -> Template.curCartridge()

Template.cartridgesPageT.events
    'click a': () ->
        $("#cartridgesList li.active").removeClass 'active'
        $("#"+this._id).parent().addClass 'active'
        Template.cartridgesPageT.selectedCartridgeId = this._id
        $('#cartridgeBox').html Meteor.render -> Template.curCartridge()