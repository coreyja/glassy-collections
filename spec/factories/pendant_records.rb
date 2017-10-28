# frozen_string_literal: true

FactoryBot.define do
  factory :pendant_record do
    user
    pendant { create :glass_art_piece, :wearable }
  end
end
