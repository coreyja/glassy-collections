# frozen_string_literal: true
class ArtistGroup < ApplicationRecord
  has_many :artist_artist_groups
  has_many :artists, through: :artist_artist_groups

  def collab?
    artists.count > 1
  end
end
