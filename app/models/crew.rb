class Crew < ActiveRecord::Base
  belongs_to :user
  alias_attribute :leader, :user

  validates :name, presence: true
  validates :leader, presence: true
end
