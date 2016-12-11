class U2fRegistration < ApplicationRecord
  belongs_to :user

  validates! :user, :key_handle, :public_key, :certificate, :counter, presence: true
end
