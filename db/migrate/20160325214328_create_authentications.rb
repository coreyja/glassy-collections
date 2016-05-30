class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :token, null: false
      t.string :username, null: true

      t.belongs_to :user, null: false

      t.timestamps null: false
    end
    add_index :authentications, :user_id
    add_index :authentications, [:provider, :uid], unique: true
    add_foreign_key :authentications, :users
  end
end
