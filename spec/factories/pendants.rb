# frozen_string_literal: true
FactoryGirl.define do
  factory :pendant do
    name 'Pendant'
    user
    artist
    artist_group

    trait :ignore_validations do
      to_create { |instance| instance.save!(validate: false) }
    end
  end
end
