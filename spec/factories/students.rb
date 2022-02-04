# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    status { :ready }
    description { FFaker::Book.description }

    association :user
  end
end
