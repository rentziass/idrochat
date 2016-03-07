class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  searchkick

  has_many :messages
  has_many :chat_users
  has_many :private_chats, through: :chat_users

  validates :username, uniqueness: true

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
