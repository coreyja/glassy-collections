module CurrentUser
  class CrewsController < ApplicationController
    def index
      @crews = current_user.ownded_crews
    end

    def new
      @crew = current_user.ownded_crews.new
    end

    def create
      @crew = current_user.ownded_crews.new create_params
      if @crew.save
        redirect_to action: :index
      else
        render :new
      end
    end

    private

    def create_params
      params.require(:crew).permit(:name)
    end
  end
end
