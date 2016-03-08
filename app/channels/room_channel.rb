# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params[:room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create! content: data['message'], user_id: data['user_id'], room_id: data['room_id']
  end

  def started_typing(data)
    ActionCable.server.broadcast "room_channel_#{params[:room_id]}", new_typer: data['username']
  end

  def stopped_typing(data)
    ActionCable.server.broadcast "room_channel_#{params[:room_id]}", old_typer: data['username']
  end
end
