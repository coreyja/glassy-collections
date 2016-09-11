module Api
  module CurrentUser
    class PushNotificationSubscriptionsController < ApplicationController
      def create
        current_user.push_notification_subscriptions.find_or_create_by!(subscription_id: subscription_id)
        head :no_content
      end

      private

      def subscription_id
        params[:subscription_id]
      end
    end
  end
end
