# frozen_string_literal: true
class ArtistGroup < ApplicationRecord
  has_many :artist_artist_groups, dependent: :destroy
  has_many :artists, through: :artist_artist_groups
  has_many :pendants

  validate :must_have_unique_artists

  def collab?
    artists.count > 1
  end

  def name
    artists.pluck(:name).join(' & ')
  end

  private

  def must_have_unique_artists
    if other_artist_groups_with_same_artists.any?
      errors.add(:artists, 'Can not have duplicate ArtistGroups with the same Artists')
    end
  end

  def other_artist_groups_with_same_artists
    ArtistGroup.joins(:artists).merge(Artist.where(id: artist_ids)).where.not(id: self)
  end
end
