ready = ->
  App.user = App.cable.subscriptions.create { channel: "UserChannel", user_id: window.current_user_id },
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      if data['new_message']
        unless parseInt(window.room_id) == data['new_message']['room_id']
          $("a.room_link[data-room-id=" + data['new_message']['room_id'] + "] span.unseen_count").html data['new_message']['unseen_count']
          Materialize.toast(data['new_message']['message'], 4000)

        li = $("a.room_link[data-room-id=" + data['new_message']['room_id'] + "]").parent()
        $(li).detach()
        $("ul#room_list").prepend(li)
$(document).ready ->
  ready()
