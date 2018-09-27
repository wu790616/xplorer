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

  def system_map(base, scale, page)
    topics = []
    links = []
    xmap = []
    if(scale == 0)
      # JSON for Xmap
      if(page == 0)                # first X map
        link1  = (self.topic_link1_id == nil) ? nil : Topic.find(self.topic_link1_id)
        link2  = (self.topic_link2_id == nil) ? nil : Topic.find(self.topic_link2_id)
        link3  = (self.topic_link3_id == nil) ? nil : Topic.find(self.topic_link3_id)
        link4  = (self.topic_link4_id == nil) ? nil : Topic.find(self.topic_link4_id)
      else                                           # second X map
        link1  = (self.topic_link5_id == nil) ? nil : Topic.find(self.topic_link5_id)
        link2  = (self.topic_link6_id == nil) ? nil : Topic.find(self.topic_link6_id)
        link3  = (self.topic_link7_id == nil) ? nil : Topic.find(self.topic_link7_id)
        link4  = (self.topic_link8_id == nil) ? nil : Topic.find(self.topic_link8_id)
      end

      next_page = (page == 0) ? 1 : 0
      topics.push({name: "#{self.name}", base: "#{self.id}", center: "#{self.id}", from: self.id, page: page      ,strength: 2000})
      topics.push({name: "#{link1.name }", base: "#{base.id}"  , center: "#{link1.id }", from: self.id, page: 0         ,strength: 1000}) unless (link1 == nil)
      topics.push({name: "#{link2.name }", base: "#{base.id}"  , center: "#{link2.id }", from: self.id, page: 0         ,strength: 1000}) unless (link2 == nil)
      topics.push({name: "#{link3.name }", base: "#{base.id}"  , center: "#{link3.id }", from: self.id, page: 0         ,strength: 1000}) unless (link3 == nil)
      topics.push({name: "#{link4.name }", base: "#{base.id}"  , center: "#{link4.id }", from: self.id, page: 0         ,strength: 1000}) unless (link4 == nil)
      topics.push({name: "Re-generate"   , base: "#{base.id}"  , center: "#{self.id}", from: self.id, page: next_page ,strength: 2000}) unless (self.links_count <= 4)

      links.push({source: 0, target:1}) unless (link1 == nil)
      links.push({source: 0, target:2}) unless (link2 == nil)
      links.push({source: 0, target:3}) unless (link3 == nil)
      links.push({source: 0, target:4}) unless (link4 == nil)

      xmap.push({topics: topics})
      xmap.push({links: links})
    end
  end
end
