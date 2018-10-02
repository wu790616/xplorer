class Notification < ApplicationRecord
  after_create -> { NotificationRelayJob.perform_later(self, Notification.unread.count) }

  scope :unread, -> { where( :read => false ) }

  belongs_to :user
  belongs_to :recipient, class_name: "User"
  belongs_to :notifiable, polymorphic: true
end
