class Dab < ActiveRecord::Base
  belongs_to :user
  belongs_to :nail

  validates :user_id, presence: true
  validates :nail_id, presence: true
  validates :milliseconds, numericality: { only_integer: true }
end
