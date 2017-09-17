class CreatePushNotificationSubscription < ActiveRecord::Migration[4.2]
  def change
    create_table :push_notification_subscriptions do |t|
      t.string :subscription_id, null: false
      t.references :user, null: false

      t.timestamps null: false
    end
    add_index :push_notification_subscriptions, :subscription_id, unique: true
    add_index :push_notification_subscriptions, :user_id
    add_foreign_key :push_notification_subscriptions, :users
  end
end
