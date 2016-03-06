class DabsController < ApplicationController
  before_action :require_login

  def new
    dab.assign_attributes new_params
  end

  def create
    dab.assign_attributes create_params
    if dab.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def index
    @dabs = current_user.nails.map do |nail|
      { nail => nail.dabs.merge(current_user.dabs).order('created_at DESC').limit(10) }
    end.reduce({}, :merge)
    @nails = current_user.nails
  end

  private

  def dab
    @dab ||= Dab.new
  end

  def new_params
    params.permit(:user_id, :nail_id, :milliseconds)
  end

  def create_params
    params.require(:dab).permit(:user_id, :nail_id, :milliseconds, :rating)
  end
end
