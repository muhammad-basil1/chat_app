class MessagesController < ApplicationController

  # GET chat_rooms/:id/messages/
  def index
    @messages = Message.fetch_messages(params[:id])
    # respond_to do |format|
      # format.js
    # end
  end

  def create
    @message = Message.create(message_params)
    respond_to do |format|
      format.html { redirect_to @message }
    end
  end

  private

  def message_params
    params.require(:message).permit!(:sender_id, :body, :chat_room_id)
  end
end
