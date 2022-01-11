# frozen_string_literal: true

FactoryBot.define do
  factory :challenge do
    title { FFaker::Book.title }
    description { FFaker::Book.description }
    difficulty { rand 1..10 }
    duration { rand 1..500 }
    signature { FFaker::Internet.user_name }
    association :user

    after(:create) do |challenge|
      create(:repository, cloud_storage: challenge)
    end
  end
end
