# frozen_string_literal: true

class CollectionOwner < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :collection
end
