class Like < ApplicationRecord
  belongs_to :user
  belongs_to :issue, :counter_cache => true
end
