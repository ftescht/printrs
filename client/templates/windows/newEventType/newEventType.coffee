Template.newEventType.rendered = ()->
  $('#addEventTypeWindow').modal 'show'

  $('#addEventTypeWindow').on 'shown', ()->
    $('#addEventTypeWindow_name').val Template.newEventType.typeName if Template.newEventType.typeName
    $('#addEventTypeWindow_descr').val Template.newEventType.typeDescr if Template.newEventType.typeDescr
    $('#addEventTypeWindow_color').val Template.newEventType.typeColor if Template.newEventType.typeColor

Template.newEventType.typeId = null
Template.newEventType.typeName = null
Template.newEventType.typeDescr = null
Template.newEventType.typeColor = null

Template.newEventType.eventTypes = ()->
  return EventTypes.find {}, {sort:
    {id: 1}}

Template.newEventType.events
  'keydown #addEventTypeWindow input': (e) ->
    addEventType() if e.which == 13
  'click #addEventTypeWindow button.yes': () ->
    addEventType()

addEventType = () ->
  eventTypeId = Template.newEventType.typeId if Template.newEventType.typeId
  eventTypeName = $('#addEventTypeWindow_name').val()
  eventTypeDescr = $('#addEventTypeWindow_descr').val()
  eventTypeColor = $('#addEventTypeWindow_color').val()

  if eventTypeName.length <= 3
    alertBox 'newEventTypeAlertBox', "Name can't be blank"
    return null
  if eventTypeColor.length < 3
    alertBox 'newEventTypeAlertBox', "Color can't be blank"
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
  $('#addEventTypeWindow').modal 'hide'