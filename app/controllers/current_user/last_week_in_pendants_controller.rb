module CurrentUser
  class LastWeekInPendantsController < ApplicationController
    def show
      @last_week_in_pendants = LastWeekInPendantsImage.new user: current_user


      respond_to do |format|
        format.html do
          send_data(@last_week_in_pendants.html, type: "text/html", disposition: 'inline')
        end
        format.png do
          send_data(@last_week_in_pendants.to_png, type: "image/png", disposition: 'inline')
        end
        format.jpeg do
          send_data(@last_week_in_pendants.to_jpeg, type: "image/jpeg", disposition: 'inline')
        end
        format.jpg do
          send_data(@last_week_in_pendants.to_jpeg, type: "image/jpeg", disposition: 'inline')
        end
      end
    end

    private

  end
end
