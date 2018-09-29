class AddDetailsToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :recipient_id, :integer
    add_column :notifications, :action, :string
    add_column :notifications, :notifiable_type, :string
    add_column :notifications, :notifiable_id, :integer
  end
end
