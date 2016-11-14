# frozen_string_literal: true
class Artist < ApplicationRecord
  has_many :artist_artist_groups
  has_many :artist_groups, through: :artist_artist_groups
  has_many :pendants, through: :artist_groups

  validates :name, presence: true
end
