class Topic < ApplicationRecord
  # Topic可被多個Issue tag
  has_many :topic_tagships, dependent: :destroy
  has_many :taged_issues, through: :topic_tagships, source: :issue

  # Topic可被多個Issue tag
  has_many :topic_followships, dependent: :destroy
  has_many :followed_users, through: :topic_followships, source: :user

  # 判斷issue是否有tag自己
  def is_taged?(issue)
    self.taged_issues.include?(issue)
  end
end
