
Meteor.subscribe 'all-users'

EventTypes = new Meteor.Collection 'eventTypes'
Meteor.subscribe 'all-eventtypes', ()->
    eTypes = EventTypes.find {}
    eTypes.forEach (item) ->
        addClassColor item._id, item.color

Places = new Meteor.Collection 'places'
Meteor.subscribe 'all-places'

Cartridges = new Meteor.Collection 'cartridges'
Meteor.subscribe 'all-cartridges'

Events = new Meteor.Collection 'events'
Meteor.subscribe 'all-events'

alertBox = (id, text) ->
    alertHtml = '<div class="alert"><a class="close" data-dismiss="alert" href="#">&times;</a><strong>'+text+'</strong></div>'
    $('#'+id).html alertHtml

addClassColor = (id, color) ->
    style = $('<style>.eventType'+id+' { background: '+color+' !important; }</style>')
    $('html > head').append style
    
Meteor.Router.add
    '/'           : 'cartridgesPage'
    '/users'      : 'usersPage'
    '/eventTypes' : 'eventTypesPage'
    '/places'     : 'placesPage'

Meteor.Router.filters
    'checkLoggedIn': (page)->
        if Meteor.user()
            return page
        else
            return 'signin'

Meteor.Router.filter('checkLoggedIn');