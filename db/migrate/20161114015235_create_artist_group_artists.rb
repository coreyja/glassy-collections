class CreateArtistGroupArtists < ActiveRecord::Migration
  def change
    create_view :artist_group_artists
  end
end
