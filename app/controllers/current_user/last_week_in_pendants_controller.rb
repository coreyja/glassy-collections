# frozen_string_literal: true
module CurrentUser
  class LastWeekInPendantsController < ApplicationController
    def show
      last_week_in_pendants = LastWeekInPendantsImage.new user: current_user

      respond_to do |format|
        format.html { send_data(last_week_in_pendants.html, type: 'text/html', disposition: 'inline') }
        format.png { send_data(last_week_in_pendants.to_png, type: 'image/png', disposition: 'inline') }
        format.jpg { send_data(last_week_in_pendants.to_jpeg, type: 'image/jpeg', disposition: 'inline') }
      end
    end
  end
end
