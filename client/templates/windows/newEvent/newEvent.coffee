Template.newEvent.rendered = ()->

  $('#addEventWindow').modal 'show'

  $('#addEventWindow').on 'shown', ()->
    $('#addEventWindow_cartridgeId').val Template.newEvent.cartridgeId if Template.newEvent.cartridgeId
    $('#addEventWindow_typeId').val Template.newEvent.typeId if Template.newEvent.typeId
    $('#addEventWindow_placeId').val Template.newEvent.placeId if Template.newEvent.placeId
    $('#addEventWindow_comment').val Template.newEvent.comment if Template.newEvent.comment

    if Template.newEvent.date != null
      $('#addEventWindow_date').val Template.newEvent.date.format("dd.mm.yyyy")
    else
      $('#addEventWindow_date').val new Date().format("dd.mm.yyyy")

    $('#addEventWindow_date').datepicker({format: "dd.mm.yyyy", weekStart: 1}).on 'changeDate', (e)->
      newDate = new Date(e.date).format("dd.mm.yyyy")
      $('#addEventWindow_date').val newDate
      $('#addEventWindow_date').datepicker 'hide'

    $('#addEventWindow_dateIcon').click ()->
      $('#addEventWindow_date').datepicker 'show'

Template.newEvent.eventId = null
Template.newEvent.cartridgeId = null
Template.newEvent.typeId = null
Template.newEvent.placeId = null
Template.newEvent.date = null
Template.newEvent.comment = null

Template.newEvent.eventTypes = ()->
  return EventTypes.find()

Template.newEvent.places = ()->
  return Places.find()

Template.newEvent.cartridges = ()->
  return Cartridges.find()

Template.newEvent.events
  'keydown #addEventWindow input': (e) ->
    addEvent() if e.which == 13
  'click #addEventWindow button.yes': () ->
    addEvent()

addEvent = ()->
  eventId = Template.newEvent.eventId if Template.newEvent.eventId

  eventCartridgeId = $('#addEventWindow_cartridgeId').val()
  eventTypeId = $('#addEventWindow_typeId').val()
  placeId = $('#addEventWindow_placeId').val()
  eventComment = $('#addEventWindow_comment').val()

  eventDate = null
  dateArr = $('#addEventWindow_date').val().match(/^(\d{1,2}).(\d{1,2}).(\d{4})$/)
  eventDate = new Date (dateArr[2] + "/" + dateArr[1] + "/" + dateArr[3]) if dateArr

  error = "<ul>"
  error += "<li>Cartridge not selected</li>" if eventCartridgeId == 0
  error += "<li>Event type not selected</li>" if eventTypeId == 0
  error += "<li>Place not selected</li>" if placeId == 0
  error += "<li>Date can't be blank</li>" if eventDate == null

  if error != "<ul>"
    error += "</ul>"
    alertBox 'newEventAlertBox', error
    return null

  if eventId
    selector =
      _id: eventId
    modifier =
      $set:
        typeId: eventTypeId
        placeId: placeId
        date: eventDate
        comment: eventComment
    Events.update selector, modifier
  else
    Events.insert
      cartridgeId: eventCartridgeId
      typeId: eventTypeId
      placeId: placeId
      date: eventDate
      comment: eventComment
  $('#addEventWindow').modal 'hide'