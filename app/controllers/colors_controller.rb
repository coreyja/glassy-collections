# frozen_string_literal: true

class ColorsController < ApplicationController
  def index
    @colors = Color.all
  end

  def show
    @color = Color.find params[:id]
  end

  def new
    @color = Color.new
  end

  def create
    photo = Photo.new photo_params
    @color = Color.new color_params
    @color.sample_photo = photo if photo.valid?
    if @color.save
      redirect_to action: :index
    else
      render :new
    end
  end

  private

  def color_params
    Color::Params.new(params.require(:color).permit(:name, artist_ids: [])).attrs
  end

  def photo_params
    params.require(:color).permit(:photo)
  end
end
