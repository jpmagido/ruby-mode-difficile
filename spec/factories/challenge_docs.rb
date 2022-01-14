FactoryBot.define do
  factory :challenge_doc do
    association :doc
    association :challenge
  end
end
