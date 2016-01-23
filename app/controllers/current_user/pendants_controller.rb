class CurrentUser::PendantsController < ApplicationController
  def index
    @pendants = current_user.pendants
  end
end
