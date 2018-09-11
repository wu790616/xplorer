class TopicFollowship < ApplicationRecord
  belongs_to :user
  belongs_to :topic, counter_cache: :followers_count
end
