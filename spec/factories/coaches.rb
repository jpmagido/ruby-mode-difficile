FactoryBot.define do
  factory :coach do
    association :user
    status { :pending }
  end
end
