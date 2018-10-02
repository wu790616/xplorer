class NotificationsController < ApplicationController
  def index
    @all_notifications = Notification.where(recipient: current_user).order(created_at: :desc).page(params[:page]).per(15)
  end

  def mark_all_read
    @notifications = Notification.where(recipient: current_user).unread
    @notifications.update_all(read: true)
    
    respond_to do |format|
      format.js { render "mark_all_read" }
    end
  end

  def mark_as_read
    @notification = Notification.find(params[:id])
    @notification.read = true
    @notification.save

    respond_to do |format|
      format.js { render "mark_as_read" }
    end
  end
end
