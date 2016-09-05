class PendantRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :pendant
  belongs_to :photo

  scope :from_date, ->(date) { where('worn_on >= ?', date) }
  scope :till_date, ->(date) { where('worn_on < ?', date) }

  scope :on_date, ->(day) { where(worn_on: day) }

  before_create :assign_worn_on, if: -> { worn_on.nil? }

  private

  def assign_worn_on
    self.worn_on = Time.zone.today
  end
end
