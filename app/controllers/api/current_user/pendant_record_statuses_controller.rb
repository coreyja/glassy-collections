module Api
  module CurrentUser
    class PendantRecordStatusesController < ApplicationController
      def show
        if current_user
          render json: { pendant_recorded?: current_user.recorded_pendant_today? }
        else
          render json: { error: 'Not Authorized' }, status: 401
        end
      end

      private

      def current_user
        super || decoded_token_user
      end

      def decoded_token_user
        decoded_token['user_id'] && User.find_by(id: decoded_token['user_id'])
      end

      def decoded_token
        if auth_header.present?
          JWT.decode(auth_header, Rails.application.secrets.secret_key_base).first
        else
          {}
        end
      end

      def auth_header
        request.headers['Authorization']
      end
    end
  end
end
