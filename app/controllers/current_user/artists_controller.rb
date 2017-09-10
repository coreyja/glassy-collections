# frozen_string_literal: true
module CurrentUser
  class ArtistsController < ApplicationController
    before_action :require_login

    def index
      @artists = artists.sort_by { |artist| artist.name.downcase }
      @chart_data = Artist.where(id: artists).joins(:glass_art_pieces).
        group('Artists.id', 'Artists.name').count.map { |k, v| [k.last, v] }
    end

    private

    def artists
      Artist.joins(:glass_art_pieces).merge(current_user.glass_art_pieces).uniq
    end
  end
end
