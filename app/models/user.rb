class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :exclude_current_user, -> { where.not(id: User.current_user&.id) }

  has_many :notifications, as: :recipient, dependent: :destroy

  after_create :create_chat_rooms

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
    exclude_current_user.where.not(id: chat_rooms.pluck(:first_participent_id, :second_participent_id).flatten.uniq)
  end

  def online?
    ActiveModel::Type::Boolean.new.cast($online_users.exists(id))
  end

  def create_chat_rooms
    User.where.not(id: id).each do |user|
      ChatRoom.create(first_participent_id: user.id, second_participent_id: id)
    end
  end
end
