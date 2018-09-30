class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :issue, :counter_cache => true

  after_create_commit { notify }

  private

  def notify
    Notification.create( recipient: self.issue.user, user: self.user,  action: "bookmarked", notifiable: self.issue, content: self.issue.title )
  end
end
