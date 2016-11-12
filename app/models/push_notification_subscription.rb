# frozen_string_literal: true
class PushNotificationSubscription < ApplicationRecord
  belongs_to :user

  scope :needs_reminder, -> { joins(:user).merge(User.needs_reminder) }

  def to_push_auth
    {
      endpoint: endpoint,
      p256dh: p256dh,
      auth: auth,
    }
  end
end
