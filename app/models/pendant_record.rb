# frozen_string_literal: true
class PendantRecord < ApplicationRecord
  belongs_to :user
  belongs_to :pendant
  belongs_to :photo

  scope :worn_on, ->(day) { where(worn_on: day) }
  scope :by_worn_on, -> { order(worn_on: :desc, created_at: :desc) }

  before_create :assign_worn_on, if: -> { worn_on.nil? }

  private

  def assign_worn_on
    self.worn_on = Time.zone.today
  end
end
