# frozen_string_literal: true

FactoryBot.define do
  factory :entry do
    location { Faker::Address.street_address }
    context { Faker::TvShows::BojackHorseman.quote }
    time { Faker::Date.between(from: 2.days.ago, to: Date.today) }
    patient { create(:patient) }
  end
end
