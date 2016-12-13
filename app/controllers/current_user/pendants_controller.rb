# frozen_string_literal: true
module CurrentUser
  class PendantsController < ApplicationController
    before_action :require_login

    def index
      @pendants = current_user.pendants
      @chart_data = current_user.pendant_records.group(:pendant).count.sort.map { |k, v| [k.name, v] }
    end

    def show
      @pendant = current_user.pendants.find params[:id]
    end

    def new
      @pendant = Pendant.new
    end

    def edit
      @pendant = current_user.pendants.find params[:id]
      render :new
    end

    def create
      @pendant = Pendant.new
      if @pendant.update pendant_attrs
        redirect_to action: :index
      else
        render :new
      end
    end

    def update
      @pendant = current_user.pendants.find params[:id]
      if @pendant.update pendant_attrs
        redirect_to action: :index
      else
        render :new
      end
    end

    private

    def pendant_attrs
      Pendant::Params.new(create_params.merge(user: current_user)).attrs
    end

    def create_params
      params.require(:pendant).permit(:name, :collection_id, artist_ids: [])
    end
  end
end
