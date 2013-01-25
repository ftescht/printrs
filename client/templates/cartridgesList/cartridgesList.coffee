Template.cartridgesList.selectedCartridgeId =  0

Template.cartridgesList.cartridges = ()->
    return Cartridges.find {}, {sort: {name: 1}}

Template.cartridgesList.isAdmin = ()->
    return Meteor.user() != null and Meteor.user().group == 'admin'

Template.cartridgesList.isVisible = ()->
    return Template.cartridgesList.cartridges().count() > 0 or Template.cartridgesList.isAdmin()

Template.cartridgesList.stateStyle = ()->
    return "eventType" + this.lastState

Template.cartridgesList.cartridgeSelectedClass = ()->
    return "active" if this._id == Template.cartridgesList.selectedCartridgeId
    return ""

Template.cartridgesList.rendered = () ->
    $('a[rel="tooltip"]').tooltip {placement: 'right'}

Template.cartridgesList.events
    'click a': () ->
        if Template.cartridgesList.selectedCartridgeId != 0
            $('#'+Template.cartridgesList.selectedCartridgeId).parent().removeClass 'active'
        Template.cartridgesList.selectedCartridgeId = this._id
        $("#"+this._id).parent().addClass 'active'

        $('#cartridgeBox').html Meteor.render -> Template.curCartridge()