# frozen_string_literal: true
FactoryGirl.define do
  factory :u2f_registration do
    user
    key_handle 'FAKE_KEY_HANDLE'
    public_key 'FAKE_PUBLIC_KEY'
    certificate 'FAKE_CERTIFICATE'
    counter 0
  end
end
