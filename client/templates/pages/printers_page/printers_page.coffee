Template.printers_page.selectedPrinterId = 0

Template.printers_page.printers = ()->
  return Printers.find {}

Template.printers_page.printerSelectedClass = ()->
  return "active" if this._id == Template.printers_page.selectedPrinterId
  return ""

Template.printers_page.rendered = () ->
  $('a[rel="tooltip"]').tooltip {placement: 'right'}
  if $('#printerBox').html() == ""
    $('#printerBox').html Meteor.render -> Template.printer_widget()

Template.printers_page.events
  'click .printers_page_printer': ()->
    $("#printers_page_printersList li.active").removeClass 'active'
    $("#" + this._id).parent().addClass 'active'
    Template.printers_page.selectedPrinterId = this._id
    $('#printerBox').html Meteor.render -> Template.printer_widget()

  'click #printers_page_printerAdd': ()->
    Template.printer_window.printerId = null
    Template.printer_window.printerName = null
    Template.printer_window.printerDescr = null
    $('#windowBox').html Meteor.render ()-> Template.printer_window()
