# frozen_string_literal: true

FactoryBot.define do
  factory :admin do
    association :user
  end
end
