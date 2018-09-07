class CreateTopicFollowships < ActiveRecord::Migration[5.2]
  def change
    create_table :topic_followships do |t|
      t.integer :user_id
      t.integer :topic_id
      t.string :progress, :default => "init"
      t.timestamps
    end
  end
end
