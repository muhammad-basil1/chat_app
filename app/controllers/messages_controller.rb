class MessagesController < ApplicationController

  # GET chat_rooms/:id/messages/
  def index
    @chat_room = ChatRoom.find_by(id: params[:chat_room_id])
    @messages  = Message.fetch_messages(params[:chat_room_id])

    @chat_rooms = ChatRoom.fetch_visible_rooms

    respond_to do |format|
      format.html { render 'chat_rooms/index' }
      format.turbo_stream
    end
  end

  # chat_rooms/:id/messages/
  def create
    @message = Message.create(message_params)

    respond_to do |format|
      format.html { render 'chat_rooms/index' }
      format.turbo_stream
    end
  end

  private

  def message_params
    params.require(:message).permit(:sender_id, :body, :chat_room_id)
  end
end
