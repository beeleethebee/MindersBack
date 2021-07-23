FactoryBot.define do
  factory :category do
    name { Faker::Lorem.unique.characters(number: 20) }
    patient { rand > 0.7 ? create(:patient) : nil }
  end
end
