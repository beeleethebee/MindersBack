# frozen_string_literal: true

FactoryBot.define do
  factory :patient do
    email { Faker::Internet.unique.email }
    first_name { Faker::Name.unique.first_name }
    last_name { Faker::Name.unique.last_name }
    password { 'password' }
  end
end
