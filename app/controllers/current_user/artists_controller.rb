module CurrentUser
  class ArtistsController < ApplicationController
    before_action :require_login

    def index
      @artists = artists
      @chart_data = Pendant.where(artist: @artists).group(:artist).count.sort.map { |k, v| [k.name, v] }
    end

    private

    def artists
      current_user.pendants.map(&:artist).uniq.sort { |l,r| l.name.downcase <=> r.name.downcase }
    end
  end
end
