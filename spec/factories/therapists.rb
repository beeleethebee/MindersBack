# frozen_string_literal: true

FactoryBot.define do
  factory :therapist do
    email { Faker::Internet.unique.email }
    first_name { Faker::Name.unique.first_name }
    last_name { Faker::Name.unique.last_name }
    password { 'password' }
    address { Faker::Address.full_address }
  end
end
