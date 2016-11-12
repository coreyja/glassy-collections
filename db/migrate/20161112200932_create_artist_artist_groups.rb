class CreateArtistArtistGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_artist_groups do |t|
      t.references :artists, null: false
      t.references :artist_groups, null: false

      t.timestamps
    end
  end
end
