class CreateIssueViews < ActiveRecord::Migration[5.2]
  def change
    create_table :issue_views do |t|
      t.integer :user_id
      t.integer :issue_id
      t.integer :time
      t.date :date

      t.timestamps
    end
  end
end
