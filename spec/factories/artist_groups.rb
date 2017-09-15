# frozen_string_literal: true

FactoryGirl.define do
  factory :artist_group do
    artists { [create(:artist)] }
  end
end
