Template.users_page.selectedUserId = 0

Template.users_page.users = ()->
  return Meteor.users.find {}, {sort: {name: 1}}

Template.users_page.userSelectedClass = ()->
  return "active" if this._id == Template.users_page.selectedUserId
  return ""

Template.users_page.rendered = () ->
  $('a[rel="tooltip"]').tooltip {placement: 'right'}
  if $('#userBox').html() == ""
    $('#userBox').html Meteor.render -> Template.user_widget()

Template.users_page.events
  'click .users_page_user': () ->
    $("#users_page_usersList li.active").removeClass 'active'
    $("#" + this._id).parent().addClass 'active'
    Template.users_page.selectedUserId = this._id
    $('#userBox').html Meteor.render -> Template.user_widget()