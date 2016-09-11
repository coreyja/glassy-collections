namespace :push do
  desc "Send a Push Notification To All Subcriptions"
  task send: :environment do
    fcm = FCM.new Figaro.env.GCM_API_KEY
    fcm.send(PushNotificationSubscription.subscription_ids)
  end
end
