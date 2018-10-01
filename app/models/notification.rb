class Notification < ApplicationRecord
  after_commit -> { NotificationRelayJob.perform_later(self, Notification.count) }
  scope :unread, -> { where( :read => false ) }
  scope :read, -> { where( :read => true ) }

  belongs_to :user
  belongs_to :recipient, class_name: "User"
  belongs_to :notifiable, polymorphic: true
end
