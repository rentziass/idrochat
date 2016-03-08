class Api::V1::RoomsController < ApplicationController
  def search_user_to_add
    @room = Room.includes(:partecipants).find params[:id]
    current_partecipants = @room.partecipants
    users = User.search(
      params[:q],
      limit: 5
    )
    html = ""
    users.each do |user|
      unless current_partecipants.include? user
        html << ApplicationController.renderer.render(
          partial: "users/user_to_add_to_room",
          locals: { user: user },
          misspellings: { below: 1, edit_distance: 4 },
        )
      end
    end
    render json: { html: html }, root: false, status: 200
  end

  def add_user
    user = User.find params[:user_id]
    current_user = User.find params[:current_user_id]
    puts params.inspect.to_s
    room = Room.find params[:id]
    # room.partecipants << user
    RoomPartecipant.create room_id: room.id, user_id: params[:user_id], inviter_id: params[:current_user_id]
    room.create_hidden_message
    render json: {
      msg: "Aggiunto utente alla chat: #{user.username}",
      display_name: room.display_name(current_user),
      display_title: room.display_title(current_user),
    }
  end
end
