class Topic < ApplicationRecord
  # Topic可被多個Issue tag
  has_many :topic_tagships, dependent: :destroy
  has_many :taged_issues, through: :topic_tagships, source: :issue

  # 判斷issue是否有tag自己
  def is_taged?(issue)
    self.taged_issues.include?(issue)
  end
end
