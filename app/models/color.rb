class Color < ApplicationRecord
  belongs_to :artist_group
  belongs_to :sample_photo, class_name: 'Photo'
  has_many :artists, through: :artist_group

  has_many :glass_art_piece_colors
  has_many :glass_art_pieces, through: :glass_art_piece_colors

  def artist_ids=(artist_ids)
    self.artist_group = ArtistGroup.find_or_initialize_by_artist_ids(artist_ids)
  end

  class Params
    def initialize(params = {})
      @params = params.to_h
    end

    def attrs
      params.merge(overrides).compact
    end

    def overrides
      {
        artist_ids: artist_ids,
        name: name,
      }
    end

    private

    attr_reader :params

    def artist_ids
      params[:artist_ids].select(&:present?).map(&:to_i) if params.include?(:artist_ids)
    end

    def name
      params[:name].strip if params.include?(:name)
    end
  end
end
