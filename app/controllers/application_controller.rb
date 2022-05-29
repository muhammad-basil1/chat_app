class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :set_current_user
  before_action :set_online, unless: :devise_controller?

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    new_session_path(resource)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  def set_current_user
    User.current_user = current_user
  end

  # set to online
  def set_online
    if current_user
      $online_users.set(current_user.id, nil, ex: 5*60) # expires in 5 minutes
    end
  end
end
