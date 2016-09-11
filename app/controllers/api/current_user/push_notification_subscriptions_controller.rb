module Api
  module CurrentUser
    class PushNotificationSubscriptionsController < ApplicationController
      def create
        current_user.push_notification_subscriptions.find_or_create_by!(push_params)
        head :no_content
      end

      private

      def push_params
        params.permit(:endpoint, :p256dh, :auth)
      end
    end
  end
end
