class Issue < ApplicationRecord
  # 一個Issue屬於一個使用者
  belongs_to :user

  # 一個Issue有多個Topics
  has_many :topic_tagships, dependent: :destroy
  has_many :taged_topics, through: :topic_tagships, source: :topic

  # 一個Issue可被多個使用者like
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  # 一個Issue可被多個使用者收藏
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_users, through: :bookmarks, source: :user

  # 一個Issue可有多篇comment
  has_many :comments, dependent: :destroy

  def is_liked?(user)
    self.liked_users.include?(user)
  end

  def is_bookmarked?(user)
    self.bookmarked_users.include?(user)
  end
end
