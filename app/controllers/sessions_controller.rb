# frozen_string_literal: true

class SessionsController < Clearance::SessionsController
  def create_from_omniauth
    authentication.update_token(omniauth_hash)
    sign_in(user)
    redirect_to root_url
  end

  private

  def omniauth_hash
    request.env['omniauth.auth']
  end

  def authentication
    Authentication.find_by(omniauth_hash) || Authentication.create_with_omniauth!(omniauth_hash, current_user)
  end

  def user
    authentication.user
  end
end
