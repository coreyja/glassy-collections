# frozen_string_literal: true
class PendantSearch < ApplicationRecord
  belongs_to :pendant

  scope :for, ->(term) { where('term ilike ?', "%#{term}%") }

  private

  def readonly?
    true
  end
end
