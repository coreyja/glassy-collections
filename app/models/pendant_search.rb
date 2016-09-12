class PendantSearch < ActiveRecord::Base
  belongs_to :pendant

  scope :for, ->(term) { where('term ilike ?', "%#{term}%") }

  private

  def readonly?
    true
  end
end
