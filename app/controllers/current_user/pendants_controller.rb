module CurrentUser
  class PendantsController < ApplicationController
    before_action :require_login

    def index
      @pendants = current_user.pendants
      @chart_data = current_user.pendant_records.group(:pendant).count.map { |k, v| [k.name, v] }
    end

    def new
      @pendant = current_user.pendants.new
    end

    def create
      @pendant = current_user.pendants.new create_params
      if @pendant.save
        redirect_to action: :index
      else
        render :new
      end
    end

    private

    def create_params
      params.require(:pendant).permit(:name, :user_id, :artist_id)
    end
  end
end
