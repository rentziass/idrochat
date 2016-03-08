class GroupNotificationJob < ApplicationJob
  queue_as :default

  def perform(room_partecipant)
    partecipants = RoomPartecipant.
      where(room_id: room_partecipant.room_id).
      where.not(user_id: room_partecipant.inviter_id)

    partecipants.update_all("unseen_count = unseen_count + 1")

    room_link = Rails.application.routes.url_helpers.room_path(room_partecipant.room_id)

    partecipants.reload
    partecipants.each do |p|
      msg = if p.id == room_partecipant.id
              "<a href='#{room_link}'>#{room_partecipant.inviter.username} ti ha aggiunto a un gruppo!</a>"
            else
              "<a href='#{room_link}'>#{room_partecipant.inviter.username} ha aggiunto #{room_partecipant.user.username} a un vostro gruppo!</a>"
            end
      ActionCable.server.broadcast(
        "user_channel_#{p.user_id}",
        new_group: {
          room_id: p.room_id,
          unseen_count: p.unseen_count,
          display_name: p.room.display_name(p.user),
          display_title: p.room.display_title(p.user),
          msg: msg
        }
      )
    end
  end
end
