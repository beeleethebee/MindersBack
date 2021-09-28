# frozen_string_literal: true

FactoryBot.define do
  factory :status do
    title { Global::STATUS.sample }
    patient { create(:patient) }
    positivity { rand(0...10) }
  end
end
