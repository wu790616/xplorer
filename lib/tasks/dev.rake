namespace :dev do

  USER_NUM  = 20
  TOPIC_NUM = 20
  ISSUE_NUM = 20
  TAG_NUM = 20

  VISIT_NUM = 20
  STEPS_NUM = 20

  MAX_COMMENT = 20
  MAX_REPLY = 20

  task fake_user: :environment do
    User.destroy_all

    USER_NUM.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{(i%20)+1}.jpg")

      User.create!(
        name: "#{name}",
        email: "user_#{i.to_s}@xplorer.com",
        password: "12345678",
        introduction: FFaker::Lorem::sentence(30),
        avatar: file
      )
    end
    puts "have created fake users"
    puts "now you have #{User.count} user data (#{User.first.id}..#{User.last.id})"
  end

  task fake_topic: :environment do
    Topic.destroy_all

    TOPIC_NUM.times do |i|

      file = File.open("#{Rails.root}/public/topic/avatar#{(i%20)+1}.jpg")
      Topic.create!(
        name: "topic_#{i.to_s}",
        avatar: file
      )
    end
    Topic.all.each do |topic|
      link_id = rand(Topic.first.id..Topic.last.id-8)
      topic.name = "topic#{topic.id.to_s}"
      topic.topic_link1_id = ((link_id+0) == topic.id) ? Topic.last.id : link_id+0;
      topic.topic_link2_id = ((link_id+1) == topic.id) ? Topic.last.id : link_id+1;
      topic.topic_link3_id = ((link_id+2) == topic.id) ? Topic.last.id : link_id+2;
      topic.topic_link4_id = ((link_id+3) == topic.id) ? Topic.last.id : link_id+3;
      topic.topic_link5_id = ((link_id+4) == topic.id) ? Topic.last.id : link_id+4;
      topic.topic_link6_id = ((link_id+5) == topic.id) ? Topic.last.id : link_id+5;
      topic.topic_link7_id = ((link_id+6) == topic.id) ? Topic.last.id : link_id+6;
      topic.topic_link8_id = ((link_id+7) == topic.id) ? Topic.last.id : link_id+7;
      topic.save!
    end
    puts "have created fake topics"
    puts "now you have #{Topic.count} topics data (#{Topic.first.id}..#{Topic.last.id})"
  end

  task fake_issue: :environment do
    Issue.destroy_all

    User.all.each do |user|
      rand(1..ISSUE_NUM).times do |i|
        user.issues.create()
      end
    end

    Issue.all.each do |issue|
      issue.title = "Issue_#{issue.id}"
      issue.content = FFaker::Lorem::sentence(500)
      issue.draft = "false"
      issue.views_count = rand(1..300)
      issue.save!
    end

    puts "have created fake issues"
    puts "now you have #{Issue.count} issues data (#{Issue.first.id}..#{Issue.last.id})"
  end

################################################################################

  ########################################
  # Relationship between Users           #
  ########################################

  #create_table "user_followships", force: :cascade do |t|
  #  t.integer "user_id"
  #  t.integer "following_id"
  #  t.datetime "created_at", null: false
  #  t.datetime "updated_at", null: false
  #end
  task fake_user_followship: :environment do
    UserFollowship.destroy_all

    # 建立資料庫關聯後產生方法
    User.all.each do |user|
      rand(1..User.count).times do |i|
        user2 = User.all.sample
        if((user == user2) || (user.following?(user2)))
          #user.user_followships.create!(
          #  following: user2
          #)
        else
          UserFollowship.create(
            user_id: user.id,
            following_id: user2.id
          )
        end
      end
    end

    puts "have created fake user_followships"
    puts "now you have #{UserFollowship.count} user_followships data (#{UserFollowship.first.id}..#{UserFollowship.last.id})"
  end
  ########################################
  # Relationship between User and Topic  #
  ########################################

  task fake_topic_followship: :environment do
    TopicFollowship.destroy_all

    # 建立資料庫關聯後產生方法
    User.all.each do |user|
      rand(1..TOPIC_NUM).times do |i|
        topic = Topic.all.sample
        if user.followingtopic?(topic)
        else
          user.topic_followships.create!(
            user: user,
            topic: topic
          )
        end
      end
    end

    puts "have created fake topic_followships"
    puts "now you have #{TopicFollowship.count} topic_followships data (#{TopicFollowship.first.id}..#{TopicFollowship.last.id})"
  end

  task fake_xmap_viewlogs: :environment do
    Ahoy::Event.all.where(name: "XmapViewlog").destroy_all
    VISIT_NUM.times do |i|
      topic_from = Topic.all.sample
      step_cnt = 0
      STEPS_NUM.times do |j|
        topic_to = Topic.all.sample
        if(topic_from != topic_to)
          Ahoy::Event.create(
            visit_id: i,
            user: User.all.sample,
            name: "XmapViewlog",
            properties: {from: topic_from.id, to: topic_to.id, progress: "init"}
          )
          topic_from = topic_to
          step_cnt = step_cnt + 1
        end
      end
      puts "have created #{step_cnt} steps in visit #{i}"
    end
  end

  task fake_topic_enterlogs: :environment do
    Ahoy::Event.all.where(name: "TopicEnterlog").destroy_all
    User.all.each do |user|
      topic = Topic.all.sample
      step_cnt = 0
      STEPS_NUM.times do |j|
        topic = Topic.all.sample
        Ahoy::Event.create(
          user: user,
          name: "TopicEnterlog",
          properties: {topic: topic.id, progress: "init"}
        )
        step_cnt = step_cnt + 1
      end
      puts "have created #{step_cnt} topic enter for user #{user.name}"
    end
  end

  ########################################
  # Relationship between User and Issue  #
  ########################################

  #create_table "bookmarks", force: :cascade do |t|
  #  t.integer "user_id"
  #  t.integer "issue_id"
  #  t.datetime "created_at", null: false
  #  t.datetime "updated_at", null: false
  #end
  task fake_bookmarks: :environment do
    Bookmark.destroy_all
    User.all.each do |user|
      count = 0
      rand(1..Issue.count).times do |j|
        issue = Issue.all.sample
        if issue.is_bookmarked?(user)
          count = count
        else
          user.bookmarks.create(issue: issue)
          count = count + 1
        end
      end
      puts "have created #{count} bookmarks for user #{user.name}"
    end
    puts "now you have #{Bookmark.count} bookmarks data (#{Bookmark.first.id}..#{Bookmark.last.id})"
  end
  #create_table "comments", force: :cascade do |t|
  #  t.integer "user_id"
  #  t.integer "issue_id"
  #  t.text "content"
  #  t.datetime "created_at", null: false
  #  t.datetime "updated_at", null: false
  #end
  task fake_comments: :environment do
    Comment.destroy_all
    User.all.each do |user|
      count = 0
      MAX_COMMENT.times do |j|
        issue = Issue.all.sample
        user.comments.create(
          issue: issue,
          content: FFaker::Lorem::sentence(30)
        )
        count = count + 1
      end
      puts "have created #{count} comments for user #{user.name}"
    end
    puts "now you have #{Comment.count} comments data (#{Comment.first.id}..#{Comment.last.id})"
  end
  #create_table "issue_views", force: :cascade do |t|
  #  t.integer "user_id"
  #  t.integer "issue_id"
  #  t.integer "time"
  #  t.date "date"
  #  t.datetime "created_at", null: false
  #  t.datetime "updated_at", null: false
  #end
  #create_table "likes", force: :cascade do |t|
  #  t.integer "user_id"
  #  t.integer "issue_id"
  #  t.datetime "created_at", null: false
  #  t.datetime "updated_at", null: false
  #end
  task fake_likes: :environment do
    Like.destroy_all
    User.all.each do |user|
      count = 0
      rand(1..Issue.count).times do |j|
        issue = Issue.all.sample
        if issue.is_liked?(user)
          count = count
        else
          user.likes.create(issue: issue)
          count = count + 1
        end
      end
      puts "have created #{count} likes for user #{user.name}"
    end
    puts "now you have #{Like.count} likes data (#{Like.first.id}..#{Like.last.id})"
  end
  #create_table "replies", force: :cascade do |t|
  #  t.integer "user_id"
  #  t.integer "comment_id"
  #  t.text "content"
  #  t.datetime "created_at", null: false
  #  t.datetime "updated_at", null: false
  #end
  task fake_replies: :environment do
    Reply.destroy_all
    User.all.each do |user|
      count = 0
      MAX_REPLY.times do |j|
        comment = Comment.all.sample
        user.replies.create(
          comment: comment,
          content: FFaker::Lorem::sentence(20)
        )
        count = count + 1
      end
      puts "have created #{count} replies for user #{user.name}"
    end
    puts "now you have #{Reply.count} replies data (#{Reply.first.id}..#{Reply.last.id})"
  end

  ########################################
  # Relationship between Topic and Issue #
  ########################################

  task fake_topic_tagships: :environment do
    TopicTagship.destroy_all

    Issue.all.each do |issue|
      rand(1..TAG_NUM).times do |i|
        issue.topic_tagships.create(
          topic: Topic.all.sample
        )
      end
    end
    puts "have created fake topic_tagships"
    puts "now you have #{TopicTagship.count} topic_tagships data"
  end

################################################################################

  task fake_all: :environment do
    puts "fake_user processing..."
    Rake::Task['dev:fake_user'].execute
    puts "fake_topic processing..."
    Rake::Task['dev:fake_topic'].execute
    puts "fake_issue processing..."
    Rake::Task['dev:fake_issue'].execute

    # Relationship between Users
    puts "fake_user_followship processing..."
    Rake::Task['dev:fake_user_followship'].execute
    
    # Relationship between User and Topic
    puts "fake_topic_followship processing..."
    Rake::Task['dev:fake_topic_followship'].execute
    puts "fake_xmap_viewlogs processing..."
    Rake::Task['dev:fake_xmap_viewlogs'].execute
    puts "fake_topic_enterlogs processing..."
    Rake::Task['dev:fake_topic_enterlogs'].execute

    # Relationship between User and Issue
    puts "fake_bookmarks processing..."
    Rake::Task['dev:fake_bookmarks'].execute
    puts "fake_comments processing..."
    Rake::Task['dev:fake_comments'].execute
    puts "fake_likes processing..."
    Rake::Task['dev:fake_likes'].execute
    puts "fake_replies processing..."
    Rake::Task['dev:fake_replies'].execute
    
    # Relationship between Topic and Issue
    puts "fake_topic_tagships processing..."
    Rake::Task['dev:fake_topic_tagships'].execute

    #看還有甚麼fake都能放進來
  end
end