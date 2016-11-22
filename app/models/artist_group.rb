# frozen_string_literal: true
class ArtistGroup < ApplicationRecord
  has_many :artist_artist_groups, dependent: :destroy
  has_many :artists, through: :artist_artist_groups
  has_many :pendants

  has_many :artist_group_artists # View to do artist equality checks
  scope :with_artist_ids, ->(artist_ids) do
    ArtistGroup.joins(:artist_group_artists).merge(ArtistGroupArtist.with_artist_ids(artist_ids))
  end

  validate :must_have_unique_artists

  def self.find_by_artist_ids(artist_ids)
    with_artist_ids(artist_ids).first
  end

  def self.find_or_initialize_by_artist_ids(artist_ids)
    find_by_artist_ids(artist_ids) || new(artists: Artist.where(id: artist_ids))
  end

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
    ArtistGroup.with_artist_ids(artist_ids).where.not(id: id)
  end

  class ArtistGroupArtist < ApplicationRecord
    self.table_name = 'artist_group_artists'

    belongs_to :artist_group
    scope :with_artist_ids, ->(artist_ids) do
      if artist_ids.empty?
        ArtistGroupArtist.where('artist_ids = ARRAY[]::INTEGER[]')
      else
        ArtistGroupArtist.where('artist_ids = ARRAY[:artists_ids]', artists_ids: artist_ids.sort)
      end
    end

    private

    def readonly?
      true
    end
  end
end
