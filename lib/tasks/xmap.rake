namespace :xmap do
  #create_table "xplorer_maps", force: :cascade do |t|
  #  t.integer "from_id"
  #  t.integer "to_id"
  #  t.integer "strength", default: 0
  #  t.datetime "created_at", null: false
  #  t.datetime "updated_at", null: false
  #end
  #create_table "topic_tagships", force: :cascade do |t|
  #  t.integer "issue_id"
  #  t.integer "topic_id"
  #  t.string "progress", default: "init"
  #  t.datetime "created_at", null: false
  #  t.datetime "updated_at", null: false
  #end

  task :create_link, [:from_topic, :to_topic] => [:environment] do |t, args|
    puts "Inside xmap:create_link"
    link = XplorerMap.all.where(from_id: args[:from_topic], to_id: args[:to_topic]).first
    if(link == nil)
      link = XplorerMap.create(from_id: args[:from_topic], to_id: args[:to_topic])
      puts "New link from #{args[:from_topic]} to #{args[:to_topic]}"
    else
      puts "Link from #{args[:from_topic]} to #{args[:to_topic]}"
    end
    link.strength = link.strength + 1
    link.save
    puts "link save"    
  end

  task viewlog: :environment do
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
  end

  task issuetag: :environment do
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
  end

  task topic_strength_enter: :environment do
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
  end

end