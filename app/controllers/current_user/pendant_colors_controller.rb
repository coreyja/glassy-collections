# frozen_string_literal: true
module CurrentUser
  class PendantColorsController < ApplicationController
    def new
      @pendant = GlassArtPiece.find params[:pendant_id]
      @color = Color.new
    end

    def create
      @pendant = GlassArtPiece.find params[:pendant_id]
      @color = Color.new create_params.merge(glass_art_pieces: [@pendant])
      if @color.save
        redirect_to my_pendant_path(@pendant)
      else
        render :new
      end
    end

    private

    def create_params
      Color::Params.new(params.require(:color).permit(:name, artist_ids: [])).attrs
    end
  end
end
