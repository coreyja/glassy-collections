# frozen_string_literal: true
class Artist < ActiveRecord::Base
  has_many :pendants

  validates :name, presence: true
end
