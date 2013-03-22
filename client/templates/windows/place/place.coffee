Template.place.rendered = ()->
  $('#showPlaceWindow').modal 'show'

Template.place.placeId = 0

Template.place.place = ()->
  Places.findOne { _id: Template.place.placeId }

Template.place.eventsList = ()->
  Events.find { placeId: Template.place.placeId }, {sort: {date: -1, lastChanges: -1}}

Template.place.eventColor = ()->
  "eventType" + this.typeId

Template.place.eventDate = ()->
  (new Date (this.date)).format("dd.mm.yyyy")

Template.place.eventType = ()->
  EventTypes.findOne { _id: this.typeId }

Template.place.eventCartridge = ()->
  Cartridges.findOne { _id: this.cartridgeId }

