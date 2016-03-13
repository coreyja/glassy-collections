class ArtistsController < ApplicationController
  before_action :require_login

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new create_params
    if @artist.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def index
    @artists = Artist.all
    @chart_data = Pendant.where(artist: @artists).group(:artist).count.map { |k, v| [k.name, v] }
  end

  private

  def create_params
    params.require(:artist).permit(:name, :instagram_username)
  end
end
