class Collection < ApplicationRecord
  has_many :collection_owners
  has_many :owners, through: :collection_owners
end
