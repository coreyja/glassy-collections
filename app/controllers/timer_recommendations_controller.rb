class TimerRecommendationsController < ApplicationController
  before_action :require_login

  def new
    @users = current_user.dabable_users
    @nails = current_user.nails
    @timer_recommendation = TimerRecommendation.new
  end

  def create
    redirect_to new_dab_path(timer_recommendation.to_dab_params)
  end

  private

  def timer_recommendation
    TimerRecommendation.new user: user, nail: nail
  end

  def user
    @_user ||= User.find(create_params[:user])
  end

  def nail
    @_nail ||= Nail.find(create_params[:nail])
  end

  def create_params
    params.require(:timer_recommendation).permit(:user, :nail)
  end
end
