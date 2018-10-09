class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :issue, :counter_cache => true

  # 一個Comment有多個Reply
  has_many :replies, dependent: :destroy

  after_create_commit { notify }

  private

  def notify
    Notification.create( recipient: self.issue.user, user: self.user,  action: "commented", notifiable: self.issue, content: self.issue.title )
  end
end
