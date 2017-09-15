# frozen_string_literal: true

class PendantSearch < ApplicationRecord
  belongs_to :glass_art_piece

  scope :for, ->(term) { where('term ilike ?', "%#{term}%") }

  private

  def readonly?
    true
  end
end
