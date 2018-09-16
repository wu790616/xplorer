class UserFollowship < ApplicationRecord
  belongs_to :user
  belongs_to :following, class_name: "User", counter_cache: :followers_count
end
