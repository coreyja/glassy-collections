class PendantRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :pendant
  belongs_to :photo

  scope :from_date, ->(date) { where('created_at > ?', date)}
  scope :till_date, ->(date) { where('created_at < ?', date)}

  scope :on_date, ->(day) { from_date(day.to_date).till_date(day.to_date + 1.day)}
end
