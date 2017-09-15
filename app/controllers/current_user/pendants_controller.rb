# frozen_string_literal: true

module CurrentUser
  class PendantsController < ApplicationController
    before_action :require_login

    def index
      @pendants = current_user.glass_art_pieces
      @chart_data = current_user.pendant_records.group(:pendant).count.sort.map { |k, v| [k.name, v] }
    end

    def show
      @pendant = current_user.glass_art_pieces.find params[:id]
    end

    def new
      @pendant = GlassArtPiece.new
    end

    def edit
      @pendant = current_user.glass_art_pieces.find params[:id]
      render :new
    end

    def create
      @pendant = GlassArtPiece.new
      if @pendant.update pendant_attrs
        redirect_to action: :index
      else
        render :new
      end
    end

    def update
      @pendant = current_user.glass_art_pieces.find params[:id]
      if @pendant.update pendant_attrs
        redirect_to action: :index
      else
        render :new
      end
    end

    private

    def pendant_attrs
      GlassArtPiece::Params::Pendant.new(create_params).attrs
    end

    def create_params
      params.require(:glass_art_piece).permit(:name, :collection_id, artist_ids: [], color_ids: [])
    end
  end
end
