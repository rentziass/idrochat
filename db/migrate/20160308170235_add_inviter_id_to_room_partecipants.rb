class AddInviterIdToRoomPartecipants < ActiveRecord::Migration[5.0]
  def change
    add_column :room_partecipants, :inviter_id, :integer
  end
end
