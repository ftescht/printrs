Template.cartridges_page.selectedCartridgeId = 0

Template.cartridges_page.cartridges = ()->
  return Cartridges.find {}, {sort: {name: 1}}

Template.cartridges_page.stateStyle = ()->
  lastEvent = Events.findOne { cartridgeId: this._id }, {'sort': {'date': -1, 'lastChanges': -1}}
  return "eventType" + lastEvent.typeId if lastEvent
  return ""

Template.cartridges_page.cartridgeSelectedClass = ()->
  return "active" if this._id == Template.cartridges_page.selectedCartridgeId
  return ""

Template.cartridges_page.rendered = () ->
  $('a[rel="tooltip"]').tooltip {placement: 'right'}
  if $('#cartridgeBox').html() == ""
    $('#cartridgeBox').html Meteor.render -> Template.cartridge_widget()

Template.cartridges_page.events
  'click .cartridges_page_cartridge': () ->
    $("#cartridges_page_cartridgesList li.active").removeClass 'active'
    $("#" + this._id).parent().addClass 'active'
    Template.cartridges_page.selectedCartridgeId = this._id
    $('#cartridgeBox').html Meteor.render -> Template.cartridge_widget()
    return false

  'click #cartridges_page_cartridgeAdd': ()->
    Template.cartridge_window.cartridgeId = null
    Template.cartridge_window.cartridgeName = null
    Template.cartridge_window.cartridgeDescr = null
    $('#windowBox').html Meteor.render ()-> Template.cartridge_window()