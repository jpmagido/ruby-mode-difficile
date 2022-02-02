# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    status { :ready }
    association :user
  end
end
