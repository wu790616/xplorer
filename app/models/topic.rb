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

  def system_map(base, scale, page, current_user)
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
      topics.push({name: "#{ self.name}", base: "#{self.id}", center: "#{ self.id}", from: self.id, page: page      ,strength: 2000})
      topics.push({name: "#{link1.name}", base: "#{base.id}", center: "#{link1.id}", from: self.id, page: 0         ,strength: 1000}) unless (link1 == nil)
      topics.push({name: "#{link2.name}", base: "#{base.id}", center: "#{link2.id}", from: self.id, page: 0         ,strength: 1000}) unless (link2 == nil)
      topics.push({name: "#{link3.name}", base: "#{base.id}", center: "#{link3.id}", from: self.id, page: 0         ,strength: 1000}) unless (link3 == nil)
      topics.push({name: "#{link4.name}", base: "#{base.id}", center: "#{link4.id}", from: self.id, page: 0         ,strength: 1000}) unless (link4 == nil)
      topics.push({name: "Re-generate"  , base: "#{base.id}", center: "#{ self.id}", from: self.id, page: next_page ,strength: 2000}) unless (self.links_count <= 4)

      links.push({source: 0, target:1}) unless (link1 == nil)
      links.push({source: 0, target:2}) unless (link2 == nil)
      links.push({source: 0, target:3}) unless (link3 == nil)
      links.push({source: 0, target:4}) unless (link4 == nil)
    elsif (scale >= 1) # one layer
      layer1 = XplorerMap.where(from_id: self.id)

      topics.push({name: self.name, base: self.id, center: self.id, from: self.id, page: 0, strength: 500})

      layer1.count.times do |i|
        to_topic = Topic.find(layer1[i].to_id)
        if current_user
          if current_user.followingtopic?(layer1[i])
            topics.push({name: Topic.find(layer1[i].to_id).name, base: layer1[i].to_id, center: layer1[i].to_id, from: layer1[i].to_id, page: 0, strength: 200})
          else
            topics.push({name: Topic.find(layer2[j].to_id).name, base: layer2[j].to_id, center: layer2[j].to_id, from: layer2[j].to_id, page: 0, strength: 50})
          end
        else
          topics.push({name: Topic.find(layer1[i].to_id).name, base: layer1[i].to_id, center: layer1[i].to_id, from: layer1[i].to_id, page: 0, strength: 50})
        end
        to_idx = topics.index {|t| t[:name] == to_topic.name}
        links.push({source: 0, target:to_idx})
      end

      if(scale >= 2)
        layer1.count.times do |i|
          from_topic = Topic.find(layer1[i].to_id)
          from_idx = topics.index {|t| t[:name] == from_topic.name}
          
          layer2 = XplorerMap.where(from_id: from_topic.id)

          layer2.count.times do |j|
            to_topic = Topic.find(layer2[j].to_id)
            to_idx = topics.index {|t| t[:name] == to_topic.name}
            if to_idx == nil
              if current_user
                if current_user.followingtopic?(layer2[j])
                  topics.push({name: Topic.find(layer2[j].to_id).name, base: layer2[j].to_id, center: layer2[j].to_id, from: layer2[j].to_id, page: 0, strength: 200})
                else
                  topics.push({name: Topic.find(layer2[j].to_id).name, base: layer2[j].to_id, center: layer2[j].to_id, from: layer2[j].to_id, page: 0, strength: 50})
                end
              else
                topics.push({name: Topic.find(layer2[j].to_id).name, base: layer2[j].to_id, center: layer2[j].to_id, from: layer2[j].to_id, page: 0, strength: 50})
              end
              to_idx = topics.index {|t| t[:name] == to_topic.name}
            end
            
            links.push({source: from_idx, target: to_idx})
          end
        end
      end
    end

    xmap.push({topics: topics})
    xmap.push({links: links})
  end
end
