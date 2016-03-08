class Room < ApplicationRecord
  has_many :messages, dependent: :destroy

  has_many :room_partecipants
  has_many :partecipants, through: :room_partecipants, source: "user"

  after_create :create_hidden_message

  def self.GENERAL
    Room.find_or_create_by name: "Generale"
  end

  def display_name(current_user)
    name || (partecipants - [current_user]).map(&:username).to_sentence
  end

  def display_title(current_user)
    name || ("Chat con " << (partecipants - [current_user]).map(&:username).to_sentence)
  end

  def unseen_count_by(current_user)
    count = room_partecipants.find_by(user_id: current_user.id).unseen_count
    return count if count > 0
    ""
  end

  def create_hidden_message
    Message.create hidden: true, room_id: id
  end
end
