class CreateChatUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :private_chat, index: true
      t.timestamps
    end
  end
end
