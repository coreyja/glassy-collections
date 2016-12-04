# frozen_string_literal: true
module CurrentUser
  class ArtistsController < ApplicationController
    before_action :require_login

    def index
      @artists = artists.sort_by { |artist| artist.name.downcase }
      @chart_data = Artist.where(id: artists).joins(:pendants).
        group('Artists.id', 'Artists.name').count.map { |k, v| [k.last, v] }
    end

    private

    def artists
      Artist.joins(:pendants).merge(current_user.pendants).uniq
    end
  end
end
