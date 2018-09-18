class AddEditTimeToIssues < ActiveRecord::Migration[5.2]
  def change
    add_column :issues, :edit_time, :datetime
  end
end
