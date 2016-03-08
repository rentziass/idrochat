class RoomPartecipant < ApplicationRecord
  belongs_to :user
  belongs_to :room
  belongs_to :inviter, class_name: "User"

  after_create_commit :notify_partecipants

  def notify_partecipants
    GroupNotificationJob.perform_later(self) if room.partecipants.count > 2
  end
end
