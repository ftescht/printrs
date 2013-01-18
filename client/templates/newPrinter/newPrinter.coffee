Meteor.startup ()->
    $('#addPrinterWindow').on 'hidden', ()->
        $("#printerId").val("")
        $("#newPrinterName").val("")
        $("#newPrinterDescr").val("")

Template.newPrinter.events
    'click button.yes': () ->
        printerName = $("#newPrinterName").val()
        if printerName.length <= 3
            alertBox "newPrinterAlertBox", "Name can't be blank"
            return null
        printerDescr = $("#newPrinterDescr").val()

        if $("#printerId").val() != ""
            selector =
                _id: $("#printerId").val()
            modifier =
                $set:
                    name: printerName
                    descr: printerDescr
            Printers.update selector, modifier
        else
            Printers.insert
                name: printerName
                descr: printerDescr
        $('#addPrinterWindow').modal('hide')