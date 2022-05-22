class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :exclude_current_user, -> { where.not(id: User.current_user&.id) }

  def name
    "#{first_name} #{last_name}"
  end

  def self.current_user=(user)
    Thread.current[:current_user] = user
  end

  def self.current_user
    Thread.current[:current_user]
  end

  def self.fetch_users_without_chats(chat_rooms)
    exclude_current_user.where.not(id: chat_rooms.pluck(:first_participent_id, :second_participent_id).flatten)
  end
end
