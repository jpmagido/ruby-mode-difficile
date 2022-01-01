# frozen_string_literal: true

FactoryBot.define do
  factory :session do
    ip_address { FFaker::Internet.ip_v4_address }
    token { SecureRandom.hex 10 }
    association :user
  end
end
