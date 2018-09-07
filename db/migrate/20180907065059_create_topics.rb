class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :name
      t.string :avatar
      t.integer :topic_link1_id
      t.integer :topic_link2_id
      t.integer :topic_link3_id
      t.integer :topic_link4_id
      t.integer :topic_link5_id
      t.integer :topic_link6_id
      t.integer :topic_link7_id
      t.integer :topic_link8_id
      t.integer :followers_count, :default => 0
      t.integer :links_count, :default => 0
      t.timestamps
    end
  end
end
