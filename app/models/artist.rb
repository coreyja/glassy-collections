# frozen_string_literal: true
class Artist < ApplicationRecord
  has_many :pendants
  has_many :artist_artist_groups
  has_many :artist_groups, through: :artist_artist_groups

  validates :name, presence: true
end
