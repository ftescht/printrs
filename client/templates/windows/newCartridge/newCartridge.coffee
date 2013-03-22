Template.newCartridge.rendered = ()->
  $('#addCartridgeWindow').modal 'show'

  $('#addCartridgeWindow').on 'shown', ()->
    $('#addCartridgeWindow_name').val Template.newCartridge.cartridgeName if Template.newCartridge.cartridgeName
    $('#addCartridgeWindow_descr').val Template.newCartridge.cartridgeDescr if Template.newCartridge.cartridgeDescr

Template.newCartridge.cartridgeId = null
Template.newCartridge.cartridgeName = null
Template.newCartridge.cartridgeDescr = null

Template.newCartridge.events
    'keydown #addCartridgeWindow input': (e) ->
        addCartridge()  if e.which == 13
    'click #addCartridgeWindow button.yes': () ->
        addCartridge()

addCartridge = ()->
    cartridgeId = Template.newCartridge.cartridgeId if Template.newCartridge.cartridgeId
    cartridgeName = $('#addCartridgeWindow_name').val()
    cartridgeDescr = $('#addCartridgeWindow_descr').val()

    if cartridgeName.length <= 3
        alertBox 'newCartridgeAlertBox', "Name can't be blank"
        return null

    if cartridgeId
        selector =
            _id: cartridgeId
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