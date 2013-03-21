Template.place.rendered = () ->
    $('#showPlaceWindow').on 'hide', ()->
        $('#showPlaceWindow_placeId').val null
        $('#showPlaceWindow_name').text null
        $("#showPlaceWindow_placeEventsList").html null

    $('#showPlaceWindow').on 'show', ()->
        place = Places.findOne { _id: $('#showPlaceWindow_placeId').val() }
        $('#showPlaceWindow_name').text place.name
        $("#showPlaceWindow_placeEventsList").html ""
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
            $("#showPlaceWindow_placeEventsList").append eventRow