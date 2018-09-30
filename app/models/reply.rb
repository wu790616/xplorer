class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  after_create_commit { notify }

  private

  def notify
    Notification.create( recipient: self.comment.user, user: self.user,  action: "replied", notifiable: self.comment, content: self.comment.issue.title,
     link: Rails.application.routes.url_helpers.issue_path(self.comment.issue) )
  end
end
