class ArtistArtistGroup < ApplicationRecord
  belongs_to :artist
  belongs_to :artist_group
end
