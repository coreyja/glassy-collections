namespace :push do
  desc "Send a Push Notification To All Subcriptions"
  task send: :environment do
    PushNotificationSubscription.all.each do |sub|
      message = {
        title: 'Record Pendant',
        body: 'Do it Now!',
        icon: '/assets/launcher-icon-4x.png'
      }

      Webpush.payload_send(
        endpoint: sub.endpoint,
        message: JSON.generate(message),
        p256dh: sub.p256dh,
        auth: sub.auth,
        ttl: 600,
        api_key: Figaro.env.GCM_API_KEY
      )
    end
  end
end
