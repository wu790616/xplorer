class AddCoverToIssues < ActiveRecord::Migration[5.2]
  def change
    add_column :issues, :cover, :string
  end
end
