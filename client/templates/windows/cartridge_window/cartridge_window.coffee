Template.cartridge_window.rendered = ()->
  $('#cartridge_window').modal 'show'

  $('#cartridge_window').on 'shown', ()->
    $('#cartridge_window_title').text "Edit Cartridge" if Template.cartridge_window.cartridgeId
    $('#cartridge_window_name').val Template.cartridge_window.cartridgeName if Template.cartridge_window.cartridgeName
    $('#cartridge_window_descr').val Template.cartridge_window.cartridgeDescr if Template.cartridge_window.cartridgeDescr

Template.cartridge_window.cartridgeId = null
Template.cartridge_window.cartridgeName = null
Template.cartridge_window.cartridgeDescr = null

Template.cartridge_window.events
  'keydown #cartridge_window input': (e) ->
    addCartridge()  if e.which == 13
  'click #cartridge_window_save': () ->
    addCartridge()

addCartridge = ()->
  cartridgeId = Template.cartridge_window.cartridgeId if Template.cartridge_window.cartridgeId
  cartridgeName = $('#cartridge_window_name').val()
  cartridgeDescr = $('#cartridge_window_descr').val()

  if cartridgeName.length <= 3
    alertBox 'cartridge_window_alert', "Name can't be blank"
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
  $('#cartridge_window').modal 'hide'