# frozen_string_literal: true

FactoryGirl.define do
  factory :authentication do
    provider 'SomeCoolProvider'
    sequence(:uid, &:to_s)
    token { SecureRandom.base64 }
    user
  end
end
