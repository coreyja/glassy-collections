class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name, null: false
      t.string :instagram_username
      
      t.timestamps null: false
    end
  end
end
