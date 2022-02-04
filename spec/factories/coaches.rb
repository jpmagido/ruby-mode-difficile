# frozen_string_literal: true

FactoryBot.define do
  factory :coach do
    status { :pending }
    description { FFaker::Book.description }

    association :user
  end
end
