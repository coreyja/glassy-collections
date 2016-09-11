class PushNotificationSubscription < ActiveRecord::Base
  belongs_to :user

  scope :subscription_ids, -> { pluck(:subscription_id) }
end
