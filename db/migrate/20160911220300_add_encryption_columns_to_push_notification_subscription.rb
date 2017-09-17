class AddEncryptionColumnsToPushNotificationSubscription < ActiveRecord::Migration[4.2]
  def change
    remove_column :push_notification_subscriptions, :subscription_id, :string, null: false

    add_column :push_notification_subscriptions, :endpoint, :string, null: false
    add_column :push_notification_subscriptions, :p256dh, :string, null: false
    add_column :push_notification_subscriptions, :auth, :string, null: false

    add_index :push_notification_subscriptions, [:endpoint, :p256dh, :auth], unique: true, name: 'index_push_notification_subscriptions_on_data'
  end
end
