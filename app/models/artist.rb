# frozen_string_literal: true
class Artist < ApplicationRecord
  has_many :pendants

  validates :name, presence: true
end
