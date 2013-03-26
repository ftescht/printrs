Template.printer_widget.printer = ()->
  return Printers.findOne { _id: Template.printers_page.selectedPrinterId }

Template.printer_widget.isVisible = ()->
  if Template.printer_widget.printer()
    return true
  return false

Template.printer_widget.canDel = ()->
  if Template.printer_widget.printer()
    return true
  return false

Template.printer_widget.events
  'click #printer_widget_printerEdit': ()->
    if Template.printer_widget.printer()
      Template.printer_window.printerId = Template.printer_widget.printer()._id
      Template.printer_window.printerName = Template.printer_widget.printer().name
      Template.printer_window.printerDescr = Template.printer_widget.printer().descr
      $('#windowBox').html Meteor.render ()-> Template.printer_window()

  'click #printer_widget_printerRemove': () ->
    if Template.printer_widget.printer()
      Printers.remove
        _id: Template.printer_widget.printer()._id
      $("#printerBox").html null