# frozen_string_literal: true

class Collection < ApplicationRecord
  has_many :collection_owners
  has_many :owners, through: :collection_owners

  has_many :glass_art_pieces

  def owners_names
    owners.pluck(:name).join(' ')
  end
end
