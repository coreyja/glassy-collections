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
      @pendant = current_user.pendants.new
    end

    def edit
      @pendant = current_user.pendants.find params[:id]
      render :new
    end

    def create
      @pendant = current_user.pendants.new create_params
      if @pendant.save
        redirect_to action: :index
      else
        render :new
      end
    end

    def update
      @pendant = current_user.pendants.find params[:id]
      if @pendant.update create_params
        redirect_to action: :index
      else
        render :new
      end
    end

    private

    def create_params
      params.require(:pendant).permit(:name, :artist_id)
    end
  end
end
