class AddStrengthToTopicfollowships < ActiveRecord::Migration[5.2]
  def change
    add_column :topic_followships, :strength, :integer, :default => 0
  end
end
