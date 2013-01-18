Meteor.startup ()->
    $('#addCartridgeWindow').on 'hidden', ()->
        $("#cartridgeId").val("")
        $("#newCartridgeName").val("")
        $("#newCartridgeDescr").val("")

Template.newCartridge.events
    'click button.yes': () ->
        cartridgeName = $("#newCartridgeName").val()
        if cartridgeName.length <= 3
            alertBox "newCartridgeAlertBox", "Name can't be blank"
            return null
        cartridgeDescr = $("#newCartridgeDescr").val()

        if $("#cartridgeId").val() != ""
            selector =
                _id: $("#cartridgeId").val()
            modifier =
                $set:
                    name: cartridgeName
                    descr: cartridgeDescr
            Cartridges.update selector, modifier
        else
            Cartridges.insert
                name: cartridgeName
                descr: cartridgeDescr
        $('#addCartridgeWindow').modal('hide')