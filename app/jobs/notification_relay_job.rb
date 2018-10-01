class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification, counter)
    # Do something later
    html = ApplicationController.render partial: "notifications/share_list", locals: {notification: notification}, formats: [:html]
    ActionCable.server.broadcast "notifications:#{notification.recipient_id}", html: html, counter: render_counter(counter)
  end

  private
  
  def render_counter(counter)
    ApplicationController.renderer.render(partial: 'notifications/counter', locals: { counter: counter })
  end

end
