class CreateArtistArtistGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_artist_groups do |t|
      t.references :artist, null: false, foreign_key: true
      t.references :artist_group, null: false, foreign_key: true

      t.timestamps
    end
    add_index :artist_artist_groups, [:artist_id, :artist_group_id], unique: true, name: 'index_artist_artist_groups_on_join_uniqueness'
  end
end
