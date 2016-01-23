class CurrentUser::PendantsController < ApplicationController
  before_action :require_login

  def index
    @pendants = current_user.pendants
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
