Template.printer_window.rendered = ()->
  $('#printer_window').modal 'show'

  $('#printer_window').on 'shown', ()->
    $('#printer_window_title').text "Edit Printer" if Template.printer_window.printerId
    $('#printer_window_name').val Template.printer_window.printerName if Template.printer_window.printerName
    $('#printer_window_descr').val Template.printer_window.printerDescr if Template.printer_window.printerDescr

Template.printer_window.printerId = null
Template.printer_window.printerName = null
Template.printer_window.printerDescr = null

Template.printer_window.events
  'keydown #printer_window input': (e)->
    addPrinter() if e.which == 13
  'click #printer_window_save': ()->
    addPrinter()

addPrinter = ()->
  printerId = Template.printer_window.printerId if Template.printer_window.printerId
  printerName = $('#printer_window_name').val()
  printerDescr = $('#printer_window_descr').val()

  if printerName.length <= 3
    alertBox 'printer_window_alert', "Name can't be blank"
    return null

  if printerId
    selector =
      _id: printerId
    modifier =
      $set:
        name: printerName
        descr: printerDescr
    Printers.update selector, modifier
  else
    Printers.insert
      name: printerName
      descr: printerDescr
  $('#printer_window').modal 'hide'