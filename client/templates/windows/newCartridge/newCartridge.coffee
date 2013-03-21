Template.newCartridge.rendered = ()->
    $('#addCartridgeWindow').on 'hide', ()->
        $('#addCartridgeWindow_id').val null
        $('#addCartridgeWindow_name').val null
        $('#addCartridgeWindow_descr').val null

Template.newCartridge.events
    'keydown #addCartridgeWindow input': (e) ->
        if e.which == 13
            addCartridge()
    'click #addCartridgeWindow button.yes': () ->
        console.log 123;
        addCartridge()

addCartridge = ()->
    cartridgeName = $('#addCartridgeWindow_name').val()
    cartridgeDescr = $('#addCartridgeWindow_descr').val()
    
    if cartridgeName.length <= 3
        alertBox 'newCartridgeAlertBox', "Name can't be blank"
        return null

    if $('#addCartridgeWindow_id').val() != ""
        selector =
            _id: $('#addCartridgeWindow_id').val()
        modifier =
            $set:
                name: cartridgeName
                descr: cartridgeDescr
        Cartridges.update selector, modifier
    else
        Cartridges.insert
            name: cartridgeName
            descr: cartridgeDescr
    $('#addCartridgeWindow').modal 'hide'