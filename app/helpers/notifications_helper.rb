module NotificationsHelper
  def notifable_link(notification)
    case notification.notifiable_type
      when "Issue"
        return Rails.application.routes.url_helpers.issue_path(notification.notifiable)
      when "Comment"
        return Rails.application.routes.url_helpers.issue_path(notification.notifiable.issue)
      when "User"
        return Rails.application.routes.url_helpers.user_path(notification.user)
    end
  end
end
