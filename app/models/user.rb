class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  searchkick

  has_many :messages
  has_many :room_partecipants
  has_many :rooms, through: :room_partecipants

  validates :username, uniqueness: true
  after_create :add_to_general_chat

  def add_to_general_chat
    Room.GENERAL.partecipants << self
  end

  def rooms_without_general
    rooms.includes(:messages).where.not(id: Room.GENERAL.id).order("messages.created_at DESC")
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
