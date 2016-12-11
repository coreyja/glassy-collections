# frozen_string_literal: true
module CurrentUser
  class U2fRegistrationsController < ApplicationController
    before_action :require_login

    def new
      @registration_requests = u2f.registration_requests
      session[:challenges] = @registration_requests.map(&:challenge)

      key_handles = U2fRegistration.all.pluck(&:key_handle)
      @sign_requests = u2f.authentication_requests(key_handles)
    end

    def create
      response = U2F::RegisterResponse.load_from_json(u2f_registration_params[:response])

      reg = begin
        u2f.register!(session[:challenges], response)
      rescue U2F::Error => e
        @error_message = "Unable to register: #{e.class.name}"
      ensure
        session.delete(:challenges)
      end

      U2fRegistration.create!(
        user: current_user,
        certificate: reg.certificate,
        key_handle:  reg.key_handle,
        public_key:  reg.public_key,
        counter:     reg.counter,
      )

      redirect_to root_path
    end

    private

    def u2f
      # use base_url as app_id, e.g. 'http://localhost:3000'
      @u2f ||= U2F::U2F.new(request.base_url)
    end

    def u2f_registration_params
      params.require(:u2f_registration).permit(:response)
    end
  end
end
