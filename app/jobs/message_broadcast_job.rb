class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "room_channel_#{message.room_id}", message: { html: render_message(message), user_id: message.user_id }
  end

  private
    def render_message(message)
      ApplicationController.renderer.render(partial: "messages/message_server_side", locals: { message: message })
    end
end
