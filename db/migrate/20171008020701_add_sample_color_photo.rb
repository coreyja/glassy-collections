class AddSampleColorPhoto < ActiveRecord::Migration[5.1]
  def change
    add_column :colors, :sample_photo_id, :integer, unique: true, null: true
    add_foreign_key :colors, :photos, column: :sample_photo_id
    add_index :colors, :sample_photo_id, unique: true
  end
end
