class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "room_channel_#{message.room_id}", message: { html: render_message(message), user_id: message.user_id }
    spread_notifications(message)
  end

  private
    def spread_notifications(message)
      other_partecipants = RoomPartecipant.where(room_id: message.room_id).where.not(user_id: message.user_id)
      other_partecipants.update_all("unseen_count = unseen_count + 1")
      room_link = Rails.application.routes.url_helpers.room_path(message.room_id)
      other_partecipants.each do |user|
        ActionCable.server.broadcast(
          "user_channel_#{user.user_id}",
          new_message: {
            room_id: message.room_id,
            unseen_count: user.unseen_count,
            message: "<a href='#{room_link}'>#{message.user.username}: #{message.content}</a>",
          }
        )
      end
    end

    def render_message(message)
      ApplicationController.renderer.render(partial: "messages/message_server_side", locals: { message: message })
    end
end
