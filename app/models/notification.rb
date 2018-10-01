class Notification < ApplicationRecord
  after_commit -> { NotificationRelayJob.perform_later(self, Notification.count) }
  belongs_to :user
  belongs_to :recipient, class_name: "User"
  belongs_to :notifiable, polymorphic: true
end
