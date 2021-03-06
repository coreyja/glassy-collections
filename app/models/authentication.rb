# frozen_string_literal: true

class Authentication < ApplicationRecord
  belongs_to :user

  def self.create_with_omniauth!(auth_hash, current_user = nil)
    create!(
      provider: auth_hash['provider'],
      uid: auth_hash['uid'],
      token: auth_hash['credentials']['token'],
      username: auth_hash[:info][:nickname],
      user: current_user || User.create_from_omniauth!(auth_hash)
    )
  end

  def update_token(auth_hash)
    update token: auth_hash['credentials']['token']
  end
end
