class Nail < ActiveRecord::Base
  belongs_to :user

  has_many :dabs

  validates :name, presence: true
  validates :user_id, presence: true

  def time_for(user)
    dabs = self.dabs.merge user.dabs
    dabs = dabs.order('created_at DESC').limit(10)

    dabs.map(&:milliseconds).sum / dabs.count
  end
end
