module Api
  module CurrentUser
    class PendantRecordStatusesController < ApplicationController
      def show
        if current_user
          pendant_record = current_user.pendant_records.where(worn_on: Time.zone.today).sample
          render json: { pendant_recorded?: pendant_record.present?, pendant_name: pendant_record&.pendant&.name }
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
