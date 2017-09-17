class CreateArtistGroupArtists < ActiveRecord::Migration[4.2]
  def change
    create_view :artist_group_artists
  end
end
