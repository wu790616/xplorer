class RenameIssuesCountToTopics < ActiveRecord::Migration[5.2]
  def change
    rename_column :topics, :issues_count, :topic_tagships_count
  end
end
