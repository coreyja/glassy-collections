# frozen_string_literal: true

FactoryBot.define do
  factory :artist_group do
    artists { [create(:artist)] }
  end
end
