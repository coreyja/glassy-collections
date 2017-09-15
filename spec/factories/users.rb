# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    password { SecureRandom.base64 }

    trait :with_personal_collection do
      after :create do |user|
        create :collection, owners: [user], name: 'Personal Collection'
      end
    end
  end
end
