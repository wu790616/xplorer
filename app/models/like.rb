class Like < ApplicationRecord
  belongs_to :user
  belongs_to :issue, :counter_cache => true

  after_create_commit { notify }

  private

  def notify
    Notification.create( recipient: self.issue.user, user: self.user,  action: "liked", notifiable: self.issue, content: self.issue.title, 
      link: Rails.application.routes.url_helpers.issue_path(self.issue) )
  end
end
