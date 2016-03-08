class RoomsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @room = Room.includes(:messages).find params[:id]
    @messages = @room.messages
    reset_unseen_count
  end

  def general
    @room = Room.includes(:messages).GENERAL
    @messages = @room.messages
    reset_unseen_count
    render :show
  end

  def manager
    user_rooms = current_user.rooms_without_general
    searched_user = User.find params[:searched_user_id].to_i
    existing_room = user_rooms.find { |room| room.partecipants.ids.uniq.sort == [current_user.id, searched_user.id].uniq.sort }
    if existing_room
      redirect_to room_path(existing_room)
    else
      room = Room.new
      if room.save
        room.partecipants << current_user
        room.partecipants << searched_user
        redirect_to room_path(room), notice: "Inizia ora a chattare con #{searched_user.username}!"
      end
    end
  end

  private
  def reset_unseen_count
    @room.room_partecipants.find_by(user_id: current_user.id).update unseen_count: 0
  end
end
