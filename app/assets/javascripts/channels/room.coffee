App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $("#messages").append data['message']

  speak: (message, user_id) ->
    @perform 'speak', { message: message, user_id: user_id }

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13
    App.room.speak event.target.value, $("#user_id").val()
    event.target.value = ""
    event.preventDefault()
