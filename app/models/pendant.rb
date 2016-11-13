# frozen_string_literal: true
class Pendant < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  belongs_to :artist_group

  has_many :pendant_records
  has_many :pendant_searches
  has_many :artists, through: :artist_group

  scope :search, ->(term) { joins(:pendant_searches).merge(PendantSearch.for(term)).distinct }

  def to_s
    name
  end

  def artist_name
    artist_group&.name || artist.name
  end
end
