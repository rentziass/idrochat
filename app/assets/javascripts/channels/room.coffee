ready = ->
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: window.room_id },
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

    speak: (message, user_id, room_id) ->
      @perform 'speak', { message: message, user_id: user_id, room_id: room_id }

    started_typing: (username) ->
      @perform 'started_typing', { username: username }

    stopped_typing: (username) ->
      @perform 'stopped_typing', { username: username }

  $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
    if event.keyCode is 13
      App.room.speak event.target.value, $("#user_id").val(), window.room_id
      event.target.value = ""
      li = $("a.room_link[data-room-id=" + window.room_id + "]").parent()
      $(li).detach()
      $("ul#room_list").prepend(li)
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

  # Add user to room (au)
  auTypingTimer = undefined
  auDoneTypingInterval = 10
  auFinalDoneTypingInterval = 100
  au_notified_typing = false

  $(document).on 'keydown', '[data-behavior~=search_user_to_add]', (event) ->
    clearTimeout auTypingTimer
    if $('#tyingBox').val
      auTypingTimer = setTimeout((->
        if au_notified_typing is false
          # App.room.started_typing(window.current_user)
          au_notified_typing = true
      ), auDoneTypingInterval)

  $(document).on 'keyup', '[data-behavior~=search_user_to_add]', (event) ->
    clearTimeout auTypingTimer
    auTypingTimer = setTimeout((->
      # App.room.stopped_typing(window.current_user)
      $.get("/api/v1/rooms/" + window.room_id + "/search_user_to_add", { q: event.target.value }, (data) ->
        showUserResults data.html, event.target
      )
      au_notified_typing = false
    ), auFinalDoneTypingInterval)

  showUserResults = (html, input) ->
    $("#search_user_to_add_results").html html
    $("a.add_user_to_room").on("click", (event) ->
      event.preventDefault()
      $.post(
        "/api/v1/rooms/" + window.room_id + "/add_user",
        {
          user_id: $(this).data("user-id"),
          current_user_id: window.current_user_id
        }, (data) ->
          $("#search_user_to_add_results").html ""
          $("a.room_link[data-room-id=" + window.room_id + "]").html data.display_name
          $("h1.room_title").html data.display_title
          input.value = ""
          Materialize.toast(data.msg, 4000)
      )
    )

$(document).ready ->
  if window.chat_room_page
    ready()

# $(document).ready ->
#   if window.chat_room_page
#     App.room.unsubscribe
#     $("[data-behavior~=room_speaker]").off()
# )
