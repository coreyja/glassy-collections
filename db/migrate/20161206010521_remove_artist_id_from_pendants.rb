class RemoveArtistIdFromPendants < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :pendants, :artists
    remove_index :pendants, :artist_id
    remove_column :pendants, :artist_id, :integer
  end
end
