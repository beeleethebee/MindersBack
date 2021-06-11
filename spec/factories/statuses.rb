FactoryBot.define do
  factory :status do
    title { Global::Status.sample }
    patient { create(:patient) }
    positivity { rand(0...10) }
  end
end
