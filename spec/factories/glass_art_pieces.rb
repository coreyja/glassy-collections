# frozen_string_literal: true

FactoryGirl.define do
  factory :glass_art_piece do
    name 'Glass Art Piece'
    artist_group
    collection

    trait :wearable do
      wearable true
    end
  end
end
