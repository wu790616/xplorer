class Topic < ApplicationRecord
  # Topic可被多個Issue tag
  has_many :topic_tagships, dependent: :destroy
  has_many :taged_issues, through: :topic_tagships, source: :issue

  # Topic可被多個Issue tag
  has_many :topic_followships, dependent: :destroy
  has_many :followed_users, through: :topic_followships, source: :user

  # Topic可被多個Issue tag
  has_many :xplorer_maps_to, class_name: "XplorerMap", :foreign_key => "from_id", dependent: :destroy
  has_many :xplorer_next, through: :xplorer_maps_to, class_name: "Topic", :foreign_key => "to_id", source: :topic
  has_many :xplorer_maps_from, class_name: "XplorerMap", :foreign_key => "to_id", dependent: :destroy


  # 判斷issue是否有tag自己
  def is_taged?(issue)
    self.taged_issues.include?(issue)
  end

  def system_map(base, from, scale, page, current_user)
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
      topics.push({name: "#{ self.name}", base: "#{self.id}", center: "#{ self.id}", from: self.id, page: page      ,type: "center", order: 0})
      topics.push({name: "#{link1.name}", base: "#{base.id}", center: "#{link1.id}", from: self.id, page: 0         ,type: "branch", order: 1}) unless (link1 == nil)
      topics.push({name: "#{link2.name}", base: "#{base.id}", center: "#{link2.id}", from: self.id, page: 0         ,type: "branch", order: 2}) unless (link2 == nil)
      topics.push({name: "#{link3.name}", base: "#{base.id}", center: "#{link3.id}", from: self.id, page: 0         ,type: "branch", order: 3}) unless (link3 == nil)
      topics.push({name: "#{link4.name}", base: "#{base.id}", center: "#{link4.id}", from: self.id, page: 0         ,type: "branch", order: 4}) unless (link4 == nil)
      topics.push({name: "Re-generate"  , base: "#{base.id}", center: "#{ self.id}", from: self.id, page: next_page ,type: "button", order: 5}) unless (self.links_count <= 4)

      links.push({source: 0, target:1, layer: 0, from_order: 0, to_order: 1, layer: 0}) unless (link1 == nil)
      links.push({source: 0, target:2, layer: 0, from_order: 0, to_order: 2, layer: 0}) unless (link2 == nil)
      links.push({source: 0, target:3, layer: 0, from_order: 0, to_order: 3, layer: 0}) unless (link3 == nil)
      links.push({source: 0, target:4, layer: 0, from_order: 0, to_order: 4, layer: 0}) unless (link4 == nil)
    else # any layer
      layer1 = nil
      layer2 = nil
      layern = []

      topic_num = 0
      # Center Topic
      topics.push({name: self.name, base: self.id, center: self.id, from: self.id, page: 0,type: "center", order: 0, group: 0})

      layer1 = XplorerMap.where(to_id: self.id).limit(1)

      scale.times do |l|
        layer1.count.times do |i|
          from_topic = Topic.find(layer1[i].to_id)
          from_idx = topics.index {|t| t[:name] == from_topic.name}

          layer2 = XplorerMap.where(from_id: from_topic.id)
          layer2.sort_by { |n| -Topic.find(n.to_id).xplorer_maps_to.count }

          if (l == 0) || ((l > 0) & (from_idx != 0))
            layer2.each do |layer2|
              to_topic = Topic.find(layer2.to_id)
              to_idx = topics.index {|t| t[:name] == to_topic.name}
              type = (from == to_topic) ? "from" : "branch"
              if not (to_idx == 0)
                if to_idx == nil
                  topic_num = topic_num + 1
                  if current_user
                    if current_user.followingtopic?(layer2)
                      topics.push({name: Topic.find(layer2.to_id).name, base: base.id, center: layer2.to_id, from: self.id, page: 0, type: type, order: topic_num, group: (from_idx == 0) ? topic_num : from_idx})
                    else
                      topics.push({name: Topic.find(layer2.to_id).name, base: base.id, center: layer2.to_id, from: self.id, page: 0, type: type, order: topic_num, group: (from_idx == 0) ? topic_num : from_idx})
                    end
                  else
                    topics.push({name: Topic.find(layer2.to_id).name, base: base.id, center: layer2.to_id, from: self.id, page: 0, type: type, order: topic_num, group: (from_idx == 0) ? topic_num : from_idx})
                  end
                  to_idx = topics.index {|t| t[:name] == to_topic.name}
                end

                links.push({source: from_idx, target: to_idx, from_order: from_idx, to_order: to_idx, layer: l})
              end
            end
          end
          layern = layern+layer2
        end
        layer1 = layern
        layern = []
        if(topic_num > 30)
          break
        end
      end
    end  
    
    xmap.push({topics: topics})
    xmap.push({links: links})
  end
end
