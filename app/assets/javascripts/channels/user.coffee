ready = ->
  App.user = App.cable.subscriptions.create { channel: "UserChannel", user_id: window.current_user_id },
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      if data['new_message']
        unless parseInt(window.room_id) == data['new_message']['room_id']
          Materialize.toast(data['new_message']['message'], 4000)
          moveRoomToTop(data['new_message']['room_id'])
          updateUnseenCount(
            data['new_message']['room_id'],
            data['new_message']['unseen_count']
          )

      if data['new_group']
        Materialize.toast(data['new_group']['msg'], 4000)
        moveRoomToTop(data['new_group']['room_id'])
        updateUnseenCount(
          data['new_group']['room_id'],
          data['new_group']['unseen_count']
        )
        updateRoomName(
          data['new_group']['room_id'],
          data['new_group']['display_name'],
          data['new_group']['display_title']
        )

  moveRoomToTop = (room_id) ->
    li = $("a.room_link[data-room-id=" + room_id + "]").parent()
    $(li).detach()
    $("ul#room_list").prepend(li)

  updateUnseenCount = (room_id, unseen_count) ->
    $("a.room_link[data-room-id=" + room_id + "] span.unseen_count").html unseen_count

  updateRoomName = (room_id, name, title) ->
    $("a.room_link[data-room-id=" + room_id + "]").html name
    if parseInt(window.room_id) is room_id
      $("h1.room_title").html title

$(document).ready ->
  ready()
