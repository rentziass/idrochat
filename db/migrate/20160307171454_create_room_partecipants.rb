class CreateRoomPartecipants < ActiveRecord::Migration[5.0]
  def change
    create_table :room_partecipants do |t|
      t.belongs_to :room, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
