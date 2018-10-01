class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_notifications
  

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def configure_notifications
    @notifications = Notification.where(recipient: current_user).unread.order(created_at: :desc)
  end
end
