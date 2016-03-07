# RICERCA SU INPUT UTENTE
typingTimer = undefined
doneTypingInterval = 10
finaldoneTypingInterval = 100
notified_typing = false

$(document).on 'keydown', '[data-behavior~=user_search]', (event) ->
  clearTimeout typingTimer
  if $('#tyingBox').val
    typingTimer = setTimeout((->
      if notified_typing is false
        # App.room.started_typing(window.current_user)
        console.log "sta scrivendo nella ricerca"
        notified_typing = true
    ), doneTypingInterval)

$(document).on 'keyup', '[data-behavior~=user_search]', (event) ->
  clearTimeout typingTimer
  typingTimer = setTimeout((->
    # App.room.stopped_typing(window.current_user)
    console.log "finito di scrivere nella ricerca"
    $.get("/api/v1/users/search", { q: event.target.value }, (data) ->
      showUserResults data.html
    )
    notified_typing = false
  ), finaldoneTypingInterval)

showUserResults = (html) ->
  $("#search_results").html html
