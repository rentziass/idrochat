class Room < ApplicationRecord
  has_many :messages, dependent: :destroy

  has_many :room_partecipants
  has_many :partecipants, through: :room_partecipants, source: "user"

  def self.GENERAL
    Room.find_or_create_by name: "Generale"
  end

  def display_name(current_user)
    name || (partecipants - [current_user]).map(&:username)
  end
end
