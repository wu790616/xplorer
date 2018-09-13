class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :issue, :counter_cache => true

  # 一個Comment有多個Reply
  has_many :replies, dependent: :destroy
end
