# frozen_string_literal: true
module CurrentUser
  class ArtistsController < ApplicationController
    before_action :require_login

    def index
      @artists = artists
      @chart_data = Pendant.joins(:artists).merge(Artist.where(id: @artists)).group(:artist).count.sort.map { |k, v| [k.name, v] }
    end

    private

    def artists
      Artist.joins(:pendants).merge(current_user.pendants).uniq.sort_by { |artist| artist.name.downcase }
    end
  end
end
