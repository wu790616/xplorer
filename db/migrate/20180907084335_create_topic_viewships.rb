class CreateTopicViewships < ActiveRecord::Migration[5.2]
  def change
    create_table :topic_viewships do |t|
      t.integer :from_id
      t.integer :to_id
      t.integer :user_id
      t.integer :topic_viewship_id
      t.string :progress, :default => "init"
      t.timestamps
    end
  end
end
