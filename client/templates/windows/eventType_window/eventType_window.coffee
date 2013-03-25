Template.eventType_window.rendered = ()->
  $('#eventType_window').modal 'show'

  $('#eventType_window').on 'shown', ()->
    $('#eventType_window_title').text "Edit Event type" if Template.eventType_window.typeId
    $('#eventType_window_name').val Template.eventType_window.typeName if Template.eventType_window.typeName
    $('#eventType_window_descr').val Template.eventType_window.typeDescr if Template.eventType_window.typeDescr
    $('#eventType_window_color').val Template.eventType_window.typeColor if Template.eventType_window.typeColor

Template.eventType_window.typeId = null
Template.eventType_window.typeName = null
Template.eventType_window.typeDescr = null
Template.eventType_window.typeColor = null

Template.eventType_window.eventTypes = ()->
  return EventTypes.find {}, {sort:
    {id: 1}}

Template.eventType_window.events
  'keydown #eventType_window input': (e) ->
    addEventType() if e.which == 13
  'click #eventType_window_save': () ->
    addEventType()

addEventType = () ->
  eventTypeId = Template.eventType_window.typeId if Template.eventType_window.typeId
  eventTypeName = $('#eventType_window_name').val()
  eventTypeDescr = $('#eventType_window_descr').val()
  eventTypeColor = $('#eventType_window_color').val()

  if eventTypeName.length <= 3
    alertBox 'eventType_window_alert', "Name can't be blank"
    return null
  if eventTypeColor.length < 3
    alertBox 'eventType_window_alert', "Color can't be blank"
    return null

  if eventTypeId
    selector =
      _id: eventTypeId
    modifier =
      $set:
        name: eventTypeName
        descr: eventTypeDescr
        color: eventTypeColor
    EventTypes.update selector, modifier
  else
    EventTypes.insert
      name: eventTypeName
      descr: eventTypeDescr
      color: eventTypeColor
  $('#eventType_window').modal 'hide'