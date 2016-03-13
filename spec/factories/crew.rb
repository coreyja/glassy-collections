FactoryGirl.define do
  factory :crew do
    sequence :name do |n|
      "Crew #{n}"
    end
    user
  end
end
