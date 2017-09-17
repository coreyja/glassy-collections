class CreatePendants < ActiveRecord::Migration[4.2]
  def change
    create_table :pendants do |t|
      t.string :name, null: false
      t.belongs_to :artist, null: true
      t.belongs_to :user, null: false

      t.timestamps null: false
    end
    add_foreign_key :pendants, :artists
    add_foreign_key :pendants, :users

    add_index :pendants, :artist_id
    add_index :pendants, :user_id
  end
end
