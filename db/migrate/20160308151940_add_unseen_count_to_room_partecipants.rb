class AddUnseenCountToRoomPartecipants < ActiveRecord::Migration[5.0]
  def change
    add_column :room_partecipants, :unseen_count, :integer, default: 0
  end
end
