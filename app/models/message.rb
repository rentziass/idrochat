class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_create_commit { MessageBroadcastJob.perform_later(self) unless self.hidden }

  scope :visible, -> { where(hidden: false) }
end
