class CreatePrivateChats < ActiveRecord::Migration[5.0]
  def change
    create_table :private_chats do |t|

      t.timestamps
    end
  end
end
