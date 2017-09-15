# frozen_string_literal: true

class U2fSessionsController < Clearance::SessionsController
  def new
    key_handles = U2fRegistration.all.pluck(:key_handle)

    @sign_requests = u2f.authentication_requests(key_handles)
    @challenges = @sign_requests.map(&:challenge)
    session[:challenges] = @challenges
  end

  def create
    response = U2F::SignResponse.load_from_json(u2f_session_params[:response])

    registration = U2fRegistration.find_by!(key_handle: response.key_handle)

    u2f.authenticate!(session[:challenges],
                      response,
                      Base64.decode64(registration.public_key),
                      registration.counter)

    registration.update(counter: response.counter)

    sign_in(registration.user)
    redirect_to root_path
  ensure
    session.delete(:challenges)
  end

  private

  def u2f
    @u2f ||= U2F::U2F.new(request.base_url)
  end

  def u2f_session_params
    params.require(:u2f_session).permit(:response)
  end
end
