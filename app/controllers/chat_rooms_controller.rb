class ChatRoomsController < ApplicationController

  # GET chat_rooms/
  def index
    load_chat_room_components

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  private

  def load_chat_room_components
    @chat_rooms = ChatRoom.fetch_visible_rooms
  end

  def chat_room_params
    params.require(:chat_room).permit(:first_participent_id, :second_participent_id)
  end
end
