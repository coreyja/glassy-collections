# frozen_string_literal: true
class GlassArtPiece < ApplicationRecord
  belongs_to :user
  belongs_to :artist_group
  belongs_to :collection
  has_many :owners, through: :collection

  has_many :pendant_records, foreign_key: 'pendant_id'
  has_many :pendant_searches
  has_many :artists, through: :artist_group
  has_many :glass_art_piece_colors
  has_many :colors, through: :glass_art_piece_colors

  scope :search, ->(term) { joins(:pendant_searches).merge(PendantSearch.for(term)).distinct }
  scope :wearable, -> { where wearable: true }

  validates :name, :artist_group, :collection, presence: true

  def to_s
    name
  end

  def artist_name
    artist_group.name
  end

  def artist_ids=(artist_ids)
    self.artist_group = ArtistGroup.find_or_initialize_by_artist_ids(artist_ids)
  end

  module Params
    class Pendant
      def initialize(params = {})
        @params = params.to_h
      end

      def attrs
        params.merge(overrides).compact
      end

      def overrides
        {
          artist_ids: artist_ids,
          color_ids: color_ids,
          name: name,
          wearable: true,
        }
      end

      private

      attr_reader :params

      def artist_ids
        params[:artist_ids].select(&:present?).map(&:to_i) if params.include?(:artist_ids)
      end

      def color_ids
        params[:color_ids].select(&:present?).map(&:to_i) if params.include?(:color_ids)
      end

      def name
        params[:name].strip if params.include?(:name)
      end
    end
  end
end
