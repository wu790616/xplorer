class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification, counter)
    # Do something later
    ActionCable.server.broadcast "notifications:#{notification.recipient_id}", html: render_list(notification), counter: render_counter(counter)
  end

  private
  
  def render_counter(counter)
    ApplicationController.render partial: "notifications/counter", locals: { counter: counter }
  end

  def render_list(notification)
    ApplicationController.render partial: "notifications/share_list", locals: { notification: notification }, formats: [:html]
  end

end
