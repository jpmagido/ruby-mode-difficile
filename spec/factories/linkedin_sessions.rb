# frozen_string_literal: true

FactoryBot.define do
  factory :linkedin_session do
    association :user
    token { SecureRandom.hex 10 }
  end
end
