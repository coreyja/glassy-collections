# frozen_string_literal: true
class ArtistGroup < ApplicationRecord
  has_many :artist_artist_groups
  has_many :artists, through: :artist_artist_groups
  has_many :pendants

  def collab?
    artists.count > 1
  end

  def name
    artists.pluck(:name).join(' & ')
  end
end
