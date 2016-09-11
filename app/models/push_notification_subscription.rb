class PushNotificationSubscription < ActiveRecord::Base
  belongs_to :user

  def to_push_auth
    {
      endpoint: endpoint,
      p256dh: p256dh,
      auth: auth,
    }
  end
end
