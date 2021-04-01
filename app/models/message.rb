class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  after_create_commit :mark_as_unread

  def mark_as_unread
  	self.conversation.update(:read => false)
  	MessageBroadcastJob.perform_later(self)
  end
end
