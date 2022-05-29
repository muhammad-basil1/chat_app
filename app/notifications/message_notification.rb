# To deliver this notification:
#
# MessageNotification.with(post: @post).deliver_later(current_user)
# MessageNotification.with(post: @post).deliver(current_user)

class MessageNotification < Noticed::Base
  # Add your delivery methods
  
  deliver_by :database


  # Add required params
  
  param :message

  # Define helper methods to make rendering easier.
  
  def message
    t(".message", sender_name: User.find_by(id: params[:sender_id])&.name)
  end
end
