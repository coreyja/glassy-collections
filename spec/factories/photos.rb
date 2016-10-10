# frozen_string_literal: true
FactoryGirl.define do
  factory :photo do
    user
    sequence(:photo_file_name) { |n| "#{n}.jpg" }
    photo_content_type 'image/jpeg'
    photo_file_size 5
    photo_updated_at { Time.zone.now }
    photo_processing false
  end
end
