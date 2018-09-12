class TopicTagship < ApplicationRecord
  belongs_to :issue
  belongs_to :topic, :counter_cache => true
end
