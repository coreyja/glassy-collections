class User < ActiveRecord::Base
  include Clearance::User

  has_many :nails
  has_many :dabs

  has_many :pendants
  has_many :pendant_records

  has_many :photos

  has_many :ownded_crews, class_name: 'Crew'

  has_many :crew_memberships
  has_many :crews, through: :ownded_crews
end
