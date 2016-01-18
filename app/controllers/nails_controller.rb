class NailsController < ApplicationController
  before_action :require_login

  def new
    @nail = current_user.nails.new
  end

  def create
    @nail = current_user.nails.new
    @nail.assign_attributes create_params
    if @nail.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def index
    @nails = current_user.nails
  end

  def destroy
    @nail = current_user.nails.find params['id']
    @nail.destroy
    redirect_to action: :index
  end

  private

  def create_params
    params.require(:nail).permit(:user_id, :name, :description)
  end
end
