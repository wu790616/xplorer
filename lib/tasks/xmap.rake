namespace :xmap do

  # 建立尚未存在的主題關聯
  task :create_link, [:from_topic, :to_topic] => [:environment] do |t, args|
     link = XplorerMap.all.where(from_id: args[:from_topic], to_id: args[:to_topic]).first
     if(link == nil)
       link = XplorerMap.create(from_id: args[:from_topic], to_id: args[:to_topic])
     end
     link.strength = link.strength + 1
     link.save
   end

  # 更新所有主題熱門的相關推薦
  task update_link: :environment do
    Topic.all.each do |topic|
      links_count          = XplorerMap.where(from_id: topic.id).count
      topic.topic_link1_id = (links_count < 1) ? nil : XplorerMap.where(from_id: topic.id).order(strength: :desc)[0].to_id
      topic.topic_link2_id = (links_count < 2) ? nil : XplorerMap.where(from_id: topic.id).order(strength: :desc)[1].to_id
      topic.topic_link3_id = (links_count < 3) ? nil : XplorerMap.where(from_id: topic.id).order(strength: :desc)[2].to_id
      topic.topic_link4_id = (links_count < 4) ? nil : XplorerMap.where(from_id: topic.id).order(strength: :desc)[3].to_id
      topic.topic_link5_id = (links_count < 5) ? nil : XplorerMap.where(from_id: topic.id).order(strength: :desc)[4].to_id
      topic.topic_link6_id = (links_count < 6) ? nil : XplorerMap.where(from_id: topic.id).order(strength: :desc)[5].to_id
      topic.topic_link7_id = (links_count < 7) ? nil : XplorerMap.where(from_id: topic.id).order(strength: :desc)[6].to_id
      topic.topic_link8_id = (links_count < 8) ? nil : XplorerMap.where(from_id: topic.id).order(strength: :desc)[7].to_id
      topic.links_count    = links_count
      topic.save
    end
  end

  # 由 system Xplorer map 瀏覽履歷更新 Xplorer map 關聯
  task viewlog: :environment do
    puts "[Start] - viewlog"
    link_count = 0

    while 1 do
      viewsteps = Ahoy::Event.all.where(name: "XmapViewlog").select { |event| event.properties['progress'] == "init" }
      puts "in loop - #{link_count}"
      break if viewsteps.first == nil

      visitlog = viewsteps.select { |event| event.visit_id == viewsteps.first.visit_id }

      visitlog.each do |log|
        from_topic = log.properties["from"]
        to_topic = log.properties["to"]

        if from_topic != to_topic
          Rake::Task["xmap:create_link"].execute :from_topic => from_topic, :to_topic => to_topic
          link_count = link_count + 1
        end
      end

      visitlog.each do |log|
        log.properties["progress"] = "processed"
        log.save
      end
    end
    puts "[End] - viewlog"
  end

  # 由每個 issue 上的 topic tag 更新 Xplorer map 關聯
  task issuetag: :environment do
    puts "[Start] - issuetag"
    issue_cnt = 0
    link_count = 0
    
    while 1 do
      tagships = TopicTagship.all.where(progress: "init")
      break if tagships.first == nil

      group = tagships.where(issue: tagships.first.issue)

      group.each do |from_topic|
        group.each do |to_topic|
          if from_topic != to_topic
            Rake::Task["xmap:create_link"].execute :from_topic => from_topic.topic_id, :to_topic => to_topic.topic_id
            link_count = link_count + 1
          end
        end
      end

      group.each do |issue|
        issue.progress = "processed"
        issue.save
      end

      issue_cnt = issue_cnt + 1
    end
    puts "have created #{link_count} links from #{issue_cnt} issues"
    puts "[End] - issuetag"
  end

  # 由每個 user 進入 topic page 更新該 user 對 特定 topic 的關注度
  task topic_strength_enter: :environment do
    puts "[Start] - topic_strength_enter"
    enter_count = 0
    
    while 1 do
      topic_enter = Ahoy::Event.all.where(name: "TopicEnterlog").select { |event| event.properties['progress'] == "init" }
      break if topic_enter.first == nil

      user = topic_enter.first.user
      topic_enter = topic_enter.select{ |event| event.user == user }
      
      topic_enter.each do |enter|
        followship = user.topic_followships.where(topic_id: enter.properties["topic"]).first
        if followship == nil
          followship = user.topic_followships.create(topic_id: enter.properties["topic"])
        end

        followship.strength = followship.strength + 1
        followship.save
      end

      topic_enter.each do |enter|
        enter.properties["progress"] = "processed"
        enter.save
      end

      enter_count = enter_count + 1
    end
    puts "have created #{enter_count} followship"
    puts "[End] - topic_strength_enter"
  end

  # 建立每個 user 的 personal x map
  task usermap: :environment do
    puts "[Start] - usermap"
    user_count = 0
    
    users = User.all
    users.each do |user|
      if (UserXMap.all.where(user_id: user.id).first != nil)
        UserXMap.all.where(user_id: user.id).destroy_all
      end

      topics = user.topic_followships.all
      topics.each do |topic_a|
        topics.each do |topic_b|
          if(topic_a.topic_id != topic_b.topic_id)
            link = XplorerMap.all.where(from_id: topic_a.topic_id, to_id: topic_b.topic_id).first
            if(link != nil)
              UserXMap.create(user_id: user.id, from_id: topic_a.topic_id, to_id: topic_b.topic_id, strength: link.strength)
              puts "User #{user.id}: Link #{topic_a.topic_id} to #{topic_b.topic_id}"
            end
          end
        end
      end
      user_count = user_count + 1
    end

    puts "have created #{user_count} personal Xmap"
    puts "[End] - usermap"
  end

  # 建立包含所有主題與連結的 system Xplorer map 全圖
  task fullmap: :environment do
    require 'json'
    # Full map
    topics = Topic.all
    map_topics = []
    map_links = []
    topics.count.times do |i|
      map_topics.push({name: topics[i].name, base: topics[i].id, center: topics[i].id, from: topics[i].id, page: 0, strength: 200})
      topics.count.times do |j|
        link = XplorerMap.where(from_id: topics[i].id, to_id: topics[j].id).first
        if(link == nil)
        else
          map_links.push({source: i, target:j, strength: -50})
        end
      end
    end
    File.open("#{Rails.root}/app/assets/images/full_topic.json","w") do |f|
      f.write(map_topics.to_json)
    end
    File.open("#{Rails.root}/app/assets/images/full_link.json","w") do |f|
      f.write(map_links.to_json)
    end
  end
end

# Rake::Task["xmap:create_link"].execute :from_topic => from_topic, :to_topic => to_topic# 建立尚未存在的主題關聯
# Rake::Task["xmap:update_link"] # 更新所有主題熱門的相關推薦
# Rake::Task["xmap:viewlog"] # 由 system Xplorer map 瀏覽履歷更新 Xplorer map 關聯
# Rake::Task["xmap:issuetag"] # 由每個 issue 上的 topic tag 更新 Xplorer map 關聯
# Rake::Task["xmap:topic_strength_enter"] # 由每個 user 進入 topic page 更新該 user 對 特定 topic 的關注度
# Rake::Task["xmap:usermap"] # 建立每個 user 的 personal x map
# Rake::Task["xmap:fullmap"] # 建立包含所有主題與連結的 system Xplorer map 全圖