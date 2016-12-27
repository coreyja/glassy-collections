# frozen_string_literal: true
namespace :push do
  desc 'Enqueue a job to send a Push Notification To All Subcriptions'
  task enqueue_reminder: :environment do
    data = {
      title: 'Record Pendant',
      body: 'Do it Now!',
      icon: '/assets/launcher-icon-4x.png',
      tag: 'pendant-reminder',
      actions: [
        { action: 'record-pendant', title: 'Record Pendant Now' },
        { action: 'ignore', title: 'Later' },
      ],
    }

    PushNotificationSubscription.needs_reminder.each do |sub|
      Delayed::Job.enqueue Push.new(push_notification_subscription_id: sub.id, data: data)
    end
  end
end
