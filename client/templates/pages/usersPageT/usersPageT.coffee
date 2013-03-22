Template.usersPageT.selectedUserId = 0

Template.usersPageT.users = ()->
  return Meteor.users.find()

Template.usersPageT.userSelectedClass = ()->
  return "active" if this._id == Template.usersPageT.selectedUserId
  return ""

Template.usersPageT.rendered = () ->
  $('a[rel="tooltip"]').tooltip {placement: 'right'}
  if $('#userBox').html() == ""
    $('#userBox').html Meteor.render -> Template.curUser()

Template.usersPageT.events
  'click a.user': () ->
    $("#usersList li.active").removeClass 'active'
    $("#" + this._id).parent().addClass 'active'
    Template.usersPageT.selectedUserId = this._id
    $('#userBox').html Meteor.render -> Template.curUser()