module CurrentUser
  class CrewMembershipsController < ApplicationController
    def index
      @memberships = crew.crew_memberships
    end

    def new
      @membership = crew.crew_memberships.new
    end

    def create
      @membership = crew.crew_memberships.new create_params
      if @membership.save
        redirect_to action: :index
      else
        render :new
      end
    end

    private

    def crew_id
      params[:crew_id]
    end

    def crew
      @crew ||= current_user.ownded_crews.find crew_id
    end

    def create_params
      params.require(:crew_membership).permit(:user_id)
    end
  end
end