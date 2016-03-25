module CurrentUser
  class ArtistsController < ApplicationController
    before_action :require_login

    def index
      @artists = artists
      @chart_data = Pendant.where(artist: @artists).group(:artist).count.map { |k, v| [k.name, v] }
    end

    private

    def artists
      current_user.pendants.map(&:artist).uniq
    end
  end
end
