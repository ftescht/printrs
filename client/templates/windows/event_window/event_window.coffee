Template.event_window.rendered = ()->

  $('#event_window').modal 'show'

  $('#event_window').on 'shown', ()->
    $('#event_window_title').text "Edit Event" if Template.event_window.eventId
    $('#event_window_cartridgeId').val Template.event_window.cartridgeId if Template.event_window.cartridgeId
    $('#event_window_typeId').val Template.event_window.typeId if Template.event_window.typeId
    $('#event_window_placeId').val Template.event_window.placeId if Template.event_window.placeId
    $('#event_window_comment').val Template.event_window.comment if Template.event_window.comment

    if Template.event_window.date != null
      $('#event_window_date').val Template.event_window.date.format("dd.mm.yyyy")
    else
      $('#event_window_date').val new Date().format("dd.mm.yyyy")

    $('#event_window_date').datepicker({format: "dd.mm.yyyy", weekStart: 1}).on 'changeDate', (e)->
      newDate = new Date(e.date).format("dd.mm.yyyy")
      $('#event_window_date').val newDate
      $('#event_window_date').datepicker 'hide'

    $('#event_window_dateIcon').click ()->
      $('#event_window_date').datepicker 'show'

Template.event_window.eventId = null
Template.event_window.cartridgeId = null
Template.event_window.typeId = null
Template.event_window.placeId = null
Template.event_window.date = null
Template.event_window.comment = null

Template.event_window.eventTypes = ()->
  return EventTypes.find()

Template.event_window.places = ()->
  return Places.find()

Template.event_window.cartridges = ()->
  return Cartridges.find()

Template.event_window.events
  'keydown #event_window input': (e) ->
    addEvent() if e.which == 13
  'click #event_window_save': () ->
    addEvent()

addEvent = ()->
  eventId = Template.event_window.eventId if Template.event_window.eventId

  eventCartridgeId = $('#event_window_cartridgeId').val()
  eventTypeId = $('#event_window_typeId').val()
  placeId = $('#event_window_placeId').val()
  eventComment = $('#event_window_comment').val()

  eventDate = null
  dateArr = $('#event_window_date').val().match(/^(\d{1,2}).(\d{1,2}).(\d{4})$/)
  eventDate = new Date (dateArr[2] + "/" + dateArr[1] + "/" + dateArr[3]) if dateArr

  error = "<ul>"
  error += "<li>Cartridge not selected</li>" if eventCartridgeId == 0
  error += "<li>Event type not selected</li>" if eventTypeId == 0
  error += "<li>Place not selected</li>" if placeId == 0
  error += "<li>Date can't be blank</li>" if eventDate == null

  if error != "<ul>"
    error += "</ul>"
    alertBox 'event_window_alert', error
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
  $('#event_window').modal 'hide'