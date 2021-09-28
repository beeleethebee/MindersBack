# frozen_string_literal: true

FactoryBot.define do
  factory :session do
    shedulet_time { '2021-06-17 13:36:24' }
    therapist { nil }
    patient { nil }
  end
end
