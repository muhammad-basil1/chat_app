class Message < ApplicationRecord
  belongs_to :chat_room
  belongs_to :sender, class_name: 'User'

  after_create_commit { broadcast_append_to 'messages' }

  def self.fetch_messages(chat_room_id)
    where(chat_room_id: chat_room_id)
  end
end
