class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(recipient: current_user).order(created_at: :desc)
  end

  def mark_all_read
    @notifications = Notification.where(recipient: current_user).unread
    @notifications.update_all(read: true)
    redirect_back(fallback_location: root_path)
  end
end
