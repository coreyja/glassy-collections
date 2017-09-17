class CreatePhotos < ActiveRecord::Migration[4.2]
  def change
    create_table :photos do |t|
      t.timestamps null: false
      t.belongs_to :user
    end

    add_attachment :photos, :photo, null: false
    add_index :photos, :user_id
    add_foreign_key :photos, :users
  end
end
