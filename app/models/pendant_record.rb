class PendantRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :pendant
  belongs_to :photo

  scope :from_date, ->(date) { where('created_at >= ?', date.to_time.midnight) }
  scope :till_date, ->(date) { where('created_at < ?', date.to_time.midnight) }

  scope :on_date, ->(day) { from_date(day.to_time).till_date(day.to_time + 1.day) }
end
