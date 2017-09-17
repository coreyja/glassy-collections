class CreatePendantRecords < ActiveRecord::Migration[4.2]
  def change
    create_table :pendant_records do |t|
      t.belongs_to :user, null: false
      t.belongs_to :pendant, null: false
      t.belongs_to :photo

      t.timestamps null: false
    end
    add_index :pendant_records, :user_id
    add_index :pendant_records, :pendant_id
    add_index :pendant_records, :photo_id
    add_index :pendant_records, :created_at

    add_foreign_key :pendant_records, :users
    add_foreign_key :pendant_records, :pendants
    add_foreign_key :pendant_records, :photos
  end
end
