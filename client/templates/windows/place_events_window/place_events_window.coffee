Template.place_events_window.rendered = ()->
  $('#place_events_window').modal 'show'

Template.place_events_window.placeId = 0

Template.place_events_window.place = ()->
  Places.findOne { _id: Template.place_events_window.placeId }

Template.place_events_window.eventsList = ()->
  Events.find { placeId: Template.place_events_window.placeId }, {sort: {date: -1, lastChanges: -1}}

Template.place_events_window.eventColor = ()->
  "eventType" + this.typeId

Template.place_events_window.eventDate = ()->
  (new Date (this.date)).format("dd.mm.yyyy")

Template.place_events_window.eventType = ()->
  EventTypes.findOne { _id: this.typeId }

Template.place_events_window.eventCartridge = ()->
  Cartridges.findOne { _id: this.cartridgeId }

