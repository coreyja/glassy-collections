class Crew < ActiveRecord::Base
  belongs_to :user
  alias_attribute :leader, :user

  validates :name, presence: true
  validates :leader, presence: true

  has_many :crew_memberships
  has_many :users, through: :crew_memberships
  alias_attribute :members, :users

  def potential_members
    User.where('id != ?', leader.id) - members
  end
end
