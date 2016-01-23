class Dab < ActiveRecord::Base
  belongs_to :user
  belongs_to :nail

  validates :user_id, presence: true
  validates :nail_id, presence: true
  validates :milliseconds, numericality: { only_integer: true, greater_than: 0 }

  def seconds
    milliseconds / 1000.0 if milliseconds
  end

  def seconds=(seconds)
    self.milliseconds = (seconds * 1000).to_i
  end

  def ends_at
    created_at + seconds
  end
  alias_method :dabbed_at, :ends_at
end