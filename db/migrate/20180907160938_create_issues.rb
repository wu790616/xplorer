class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.integer :user_id
      t.integer :reply_id
      t.integer :topic_tag_id
      t.string :title
      t.text :content
      t.integer :likes_count, default: 0 
      t.integer :comments_count, default: 0
      t.integer :views_count, default: 0
      t.integer :bookmarks_count, default: 0
      t.integer :shares_count, default: 0
      t.boolean :draft, default: true

      t.timestamps
    end
  end
end
