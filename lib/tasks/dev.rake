namespace :dev do
  task fake_topic: :environment do
    Topic.destroy_all

    TOPIC_NUM = 20
    TOPIC_NUM.times do |i|
      link_id = rand(1..TOPIC_NUM-8)
      Topic.create!(
        name: "topic#{i.to_s}",
        avatar: "avatar",
        topic_link1_id: link_id+0,
        topic_link2_id: link_id+1,
        topic_link3_id: link_id+2,
        topic_link4_id: link_id+3,
        topic_link5_id: link_id+4,
        topic_link6_id: link_id+5,
        topic_link7_id: link_id+6,
        topic_link8_id: link_id+7
      )
    end
    puts "have created fake topics"
    puts "now you have #{Topic.count} topics data"
  end
end