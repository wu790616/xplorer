class Issue < ApplicationRecord
  # 一個Issue屬於一個使用者
  belongs_to :user

  # 一個Issue有多個Topics
  has_many :topic_tagships, dependent: :destroy
  has_many :taged_topics, through: :topic_tagships, source: :topic
end
