class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  after_create_commit { notify }

  private

  def notify
    Notification.create( recipient: self.comment.user, user: self.user,  action: "replied", notifiable: self.comment, content: self.comment.issue.title )
  end
end
