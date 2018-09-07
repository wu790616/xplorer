class CreateTopicTagships < ActiveRecord::Migration[5.2]
  def change
    create_table :topic_tagships do |t|
      t.integer :issue_id
      t.integer :topic_id
      t.string :progress, :default => "init"
      t.timestamps
    end
  end
end
