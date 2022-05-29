class Message < ApplicationRecord
  belongs_to :chat_room
  belongs_to :sender, class_name: 'User'

  after_create_commit { broadcast_append_to 'messages' }  
  after_create_commit :notify_recipient
  before_destroy      :cleanup_notifications
  has_noticed_notifications model_name: 'Notification'

  def self.fetch_messages(chat_room_id)
    where(chat_room_id: chat_room_id)
  end

  def recipient
    if sender_id != chat_room.first_participent_id
      chat_room.first_participent
    else
      chat_room.second_participent
    end
  end

  def notify_recipient
    unless recipient.online?
      MessageNotification.with(message: self, sender_id: sender_id).deliver_later(recipient)
    end
  end

  def cleanup_notifications
    notifications_as_message.destroy_all
  end
end
