class ChatRoom < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :first_participent, class_name: 'User'
  belongs_to :second_participent, class_name: 'User'

  def self.fetch_visible_rooms
    includes(:messages).where('first_participent_id = :current_user_id OR second_participent_id = :current_user_id', current_user_id: User.current_user)
  end

  def other_participent
    if first_participent_id == User.current_user.id
      second_participent
    else
      first_participent
    end
  end

  def last_message
    messages.last
  end
end
