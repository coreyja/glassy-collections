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
    @color = Color.new create_params
    if @color.save
      redirect_to action: :index
    else
      render :new
    end
  end

  private

  def create_params
    Color::Params.new(params.require(:color).permit(:name, artist_ids: [])).attrs
  end
end
