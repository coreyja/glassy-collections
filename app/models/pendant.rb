# frozen_string_literal: true
class Pendant < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  belongs_to :artist_group

  has_many :pendant_records
  has_many :pendant_searches
  has_many :artists, through: :artist_group

  scope :search, ->(term) { joins(:pendant_searches).merge(PendantSearch.for(term)).distinct }

  validates :name, :artist_group, presence: true

  def to_s
    name
  end

  def artist_name
    artist_group&.name || artist.name
  end

  def artist_ids=(artist_ids)
    self.artist_group = ArtistGroup.find_or_initialize_by_artist_ids(artist_ids)
  end

  class Params
    def initialize(params = {})
      @params = params.to_h
    end

    def attrs
      params.merge(artist_ids: artist_ids).compact
    end

    private

    attr_reader :params

    def artist_ids
      params[:artist_ids].select(&:present?).map(&:to_i) if params.include?(:artist_ids)
    end
  end
end
