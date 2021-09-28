# frozen_string_literal: true

FactoryBot.define do
  factory :entry do
    transient do
      with_categories { false }
    end

    location { Faker::Address.street_address }
    context { Faker::TvShows::BojackHorseman.quote }
    time { Faker::Date.between(from: 2.days.ago, to: Date.today) }
    patient { create(:patient) }

    after(:create) do |entry, evaluator|
      entry.categories << [create_list(:category, rand(1...5), patient: entry.patient)] if evaluator.with_categories
    end
  end
end
