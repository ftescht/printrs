Meteor.startup ()->
    $('#showPlaceWindow').on 'hidden', ()->
        $('#placeId').val null
        $('#placeName').text null
        $('#placeDescr').text null
        $("#placeEventsList").html null

    $('#showPlaceWindow').on 'shown', ()->
        place = Template.place.place()
        $('#placeName').text place.name
        $('#placeDescr').text place.descr
        events = Events.find { placeId: place._id }, {sort: {date: -1, lastChanges: -1}}
        events.forEach (event) ->
            typeName = ""
            typeName = type.name if type = EventTypes.findOne({ _id: event.typeId })
            cartrName = ""
            cartrName = cartr.name if cartr = Cartridges.findOne({ _id: event.cartridgeId })
            
            eventRow = "<tr class=\"eventType"+event.typeId+"\">"
            eventRow += "<td>"+(new Date (event.date)).format("dd.mm.yyyy")+"</td>"
            eventRow += "<td>"+cartrName+"</td>"
            eventRow += "<td>"+typeName+"</td>"
            eventRow += "<td>"+event.comment+"</td>"
            eventRow += "</tr>"
            $("#placeEventsList").append eventRow
        

Template.place.place = ()->
    return Places.findOne { _id: $('#placeId').val() }