Template.cartridgesList.selectedCartridgeId =  0

Template.cartridgesList.cartridges = ()->
    return Cartridges.find({}, {sort: {name: 1}})

Template.cartridgesList.stateStyle = ()->
    switch this.lastState
        when '1' then return "greenState"
        when '2' then return "redState"
        when '3' then return "orangeState"
        when '4' then return "blueState"
    return ""

Template.cartridgesList.cartridgeSelectedClass = ()->
    return "active" if this._id == Template.cartridgesList.selectedCartridgeId
    return ""

Template.cartridgesList.rendered = () ->
    $('a[rel="tooltip"]').tooltip({placement: 'right'})

Template.cartridgesList.events
    'click a': () ->
        if Template.cartridgesList.selectedCartridgeId != 0
            $("#"+Template.cartridgesList.selectedCartridgeId).parent().removeClass("active")
        Template.cartridgesList.selectedCartridgeId = this._id
        $("#"+this._id).parent().addClass("active")

        $("#cartridgeBox").html Meteor.render -> Template.curCartridge()