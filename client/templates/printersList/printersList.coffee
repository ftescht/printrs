Template.printersList.selectedPrinterId =  0

Template.printersList.printers = ()->
    return Printers.find {}, {sort: {name: 1}}

Template.printersList.isAdmin = ()->
    return Meteor.user() != null and Meteor.user().group == 'admin'

Template.printersList.isVisible = ()->
    return Template.printersList.printers().count() > 0 or Template.printersList.isAdmin()

Template.printersList.cartridgeSelectedClass = ()->
    return "active" if this._id == Template.printersList.selectedPrinterId
    return ""

Template.printersList.rendered = () ->
    $('a[rel="tooltip"]').tooltip({placement: 'right'})

Template.printersList.events
    'click a': () ->
        if Template.printersList.selectedPrinterId != 0
            $("#"+Template.printersList.selectedPrinterId).parent().removeClass("active")
        Template.printersList.selectedPrinterId = this._id
        $("#"+this._id).parent().addClass("active")