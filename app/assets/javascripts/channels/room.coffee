App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if data['message']
      $html = $(data['message']['html'])
      if parseInt(window.current_user_id) is data['message']['user_id']
        $html.find(".message").addClass("mine")
      $("#messages").append $html
    if data['new_typer']
      unless data['new_typer'] is window.current_user
        $("p.typing").html(data['new_typer'] + " sta scrivendo...")
    if data['old_typer']
      unless data['old_typer'] is window.current_user
        $("p.typing").html("")

  speak: (message, user_id) ->
    @perform 'speak', { message: message, user_id: user_id }

  started_typing: (username) ->
    @perform 'started_typing', { username: username }

  stopped_typing: (username) ->
    @perform 'stopped_typing', { username: username }

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13
    App.room.speak event.target.value, $("#user_id").val()
    event.target.value = ""
    event.preventDefault()

typingTimer = undefined
doneTypingInterval = 10
finaldoneTypingInterval = 500
notified_typing = false
$(document).on 'keydown', '[data-behavior~=room_speaker]', (event) ->
  clearTimeout typingTimer
  if $('#tyingBox').val
    typingTimer = setTimeout((->
      if notified_typing is false
        App.room.started_typing(window.current_user)
        notified_typing = true
    ), doneTypingInterval)
$(document).on 'keyup', '[data-behavior~=room_speaker]', (event) ->
  clearTimeout typingTimer
  typingTimer = setTimeout((->
    App.room.stopped_typing(window.current_user)
    notified_typing = false
  ), finaldoneTypingInterval)
