# frozen_string_literal: true
FactoryGirl.define do
  factory :crew_membership do
    crew
    user
  end
end
