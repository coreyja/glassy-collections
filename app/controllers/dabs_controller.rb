class DabsController < ApplicationController
  before_action :require_login

  def new
    dab
  end

  def create
    dab.assign_attributes create_params
    # dab.seconds = params['seconds'].to_f
    if dab.save
      render :create
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
    @dab ||= current_user.dabs.new
  end

  def create_params
    params.require(:dab).permit(:user_id, :nail_id, :milliseconds)
  end
end
