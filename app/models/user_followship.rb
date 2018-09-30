class UserFollowship < ApplicationRecord
  belongs_to :user, counter_cache: :followings_count
  belongs_to :following, class_name: "User", counter_cache: :followers_count

  after_create_commit { notify }

  private

  def notify
    Notification.create( recipient: self.following, user: self.user,  action: "followed", notifiable: self.following, 
      link: Rails.application.routes.url_helpers.user_path(self.user) )
  end

end
