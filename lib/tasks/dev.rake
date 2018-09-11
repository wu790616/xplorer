namespace :dev do

  USER_NUM  = 20
  TOPIC_NUM = 20
  ISSUE_NUM = 20
  TAG_NUM = 20
  TOPICFOLLOW_NUM = 200

  task fake_user: :environment do
    User.destroy_all

    USER_NUM.times do |i|
      User.create!(
        name: "user_#{i.to_s}",
        email: "user_#{i.to_s}@xplorer.com",
        password: "12345678"
      )
    end
    puts "have created fake users"
    puts "now you have #{User.count} user data (#{User.first.id}..#{User.last.id})"
  end

  task fake_topic: :environment do
    Topic.destroy_all

    TOPIC_NUM.times do |i|
      Topic.create!(
        name: "topic#{i.to_s}",
        avatar: "avatar"
      )
    end
    Topic.all.each do |topic|
      link_id = rand(Topic.first.id..Topic.last.id-8)
      topic.name = "topic#{topic.id.to_s}"
      topic.topic_link1_id = link_id+0
      topic.topic_link2_id = link_id+1
      topic.topic_link3_id = link_id+2
      topic.topic_link4_id = link_id+3
      topic.topic_link5_id = link_id+4
      topic.topic_link6_id = link_id+5
      topic.topic_link7_id = link_id+6
      topic.topic_link8_id = link_id+7
      topic.save!
    end
    puts "have created fake topics"
    puts "now you have #{Topic.count} topics data (#{Topic.first.id}..#{Topic.last.id})"
  end

  task fake_topic_followship: :environment do
    TopicFollowship.destroy_all

    # 建立資料庫關聯後產生方法
    User.all.each do |user|
      rand(1..TOPIC_NUM).times do |i|
        topic = Topic.all.sample
        user.topic_followships.create!(
          user: user,
          topic: topic
        )
      end
    end
    
    # 建立資料庫關聯前產生方法
    #TOPICFOLLOW_NUM.times do |i|
    #  TopicFollowship.create!(
    #    user_id: User.all.sample.id,
    #    topic_id: Topic.all.sample.id
    #  )
    #end

    puts "have created fake topic_followships"
    puts "now you have #{TopicFollowship.count} topic_followships data"
  end

  task fake_issue: :environment do
    Issue.destroy_all

    User.all.each do |user|
      rand(1..ISSUE_NUM).times do |i|
        Issue.create!(
          user_id: user.id,
        )
      end
    end
    Issue.all.each do |issue|
      issue.title = "Issue_#{issue.id}"
      issue.save!
    end

    puts "have created fake issues"
    puts "now you have #{Issue.count} issues data"
  end

  task fake_topic_tagships: :environment do
    TopicTagship.destroy_all

    Issue.all.each do |issue|
      rand(1..TAG_NUM).times do |i|
        topic = Topic.all.sample
        TopicTagship.create!(
          issue_id: issue.id,
          topic_id: topic.id
        )
      end
    end
    puts "have created fake topic_tagships"
    puts "now you have #{TopicTagship.count} topic_tagships data"
  end


  task fake_all: :environment do
    
    puts "fake_user processing..."
    Rake::Task['dev:fake_user'].execute
    puts "fake_topic processing..."
    Rake::Task['dev:fake_topic'].execute
    puts "fake_issue processing..."
    Rake::Task['dev:fake_issue'].execute

    puts "fake_topic_followship processing..."
    Rake::Task['dev:fake_topic_followship'].execute
    puts "fake_topic_tagships processing..."
    Rake::Task['dev:fake_topic_tagships'].execute

    #看還有甚麼fake都能放進來
  end
end