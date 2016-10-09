# frozen_string_literal: true
class Push
  TTL = 3600

  include HashAttributeAssignment

  REQUIRED_KEYS = %i(push_notification_subscription_id data).freeze

  def perform
    Webpush.payload_send payload
  rescue Webpush::InvalidSubscription
    push_notification_subscription.destroy!
  end

  private

  attr_reader :push_notification_subscription_id, :data

  def payload
    auth_params.merge(
      message: message,
      ttl: TTL,
      api_key: Figaro.env.GCM_API_KEY,
    )
  end

  def message
    JSON.generate(data)
  end

  def auth_params
    push_notification_subscription.to_push_auth
  end

  def push_notification_subscription
    PushNotificationSubscription.find(push_notification_subscription_id)
  end
end
