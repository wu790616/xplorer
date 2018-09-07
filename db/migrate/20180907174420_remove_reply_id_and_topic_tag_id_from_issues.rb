class RemoveReplyIdAndTopicTagIdFromIssues < ActiveRecord::Migration[5.2]
  def change
    remove_column :issues, :reply_id, :integer
    remove_column :issues, :topic_tag_id, :integer
  end
end
