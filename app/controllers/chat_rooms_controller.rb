class ChatRoomsController < ApplicationController

  # GET chat_rooms/
  def index
    @chat_rooms = ChatRoom.fetch_visible_rooms
    @user_without_chats = User.fetch_users_without_chats(@chat_rooms)
    respond_to do |format|
      format.html
    end
  end
end
