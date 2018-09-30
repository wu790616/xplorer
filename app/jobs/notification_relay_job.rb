class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
    # Do something later
    html = ApplicationController.render partial: "notifications/share_list", locals: {notification: notification}, formats: [:html]
    ActionCable.server.broadcast "notifications:#{notification.recipient_id}", html: html
  end
end
