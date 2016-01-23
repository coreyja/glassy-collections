class User < ActiveRecord::Base
  include Clearance::User

  has_many :nails
  has_many :dabs

  has_many :pendants
end
