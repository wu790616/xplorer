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
            link = XplorerMap.all.where(from_id: from_topic.topic_id, to_id: to_topic.topic_id).first
            if(link == nil)
              link = XplorerMap.create(from_id: from_topic.topic_id, to_id: to_topic.topic_id)
              puts "New link from #{from_topic.topic_id} to #{to_topic.topic_id}]"
            else
              puts "Link from #{from_topic.topic_id} to #{to_topic.topic_id}]"
            end
            link.strength = link.strength + 1
            link.save
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

end