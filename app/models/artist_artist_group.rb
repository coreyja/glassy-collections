class ArtistArtistGroup < ApplicationRecord
  belongs_to :artist
  belongs_to :artist_group

  validates_uniqueness_of :artist, scope: [:artist_group]
end
