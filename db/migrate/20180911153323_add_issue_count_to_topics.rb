class AddIssueCountToTopics < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :issues_count, :integer, :default => 0
  end
end
