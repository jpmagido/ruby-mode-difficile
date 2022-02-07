# frozen_string_literal: true

FactoryBot.define do
  factory :time_slot do
    start_date { FFaker::Time.datetime }
    end_date { FFaker::Time.datetime }

    association :mentorship_session
  end
end
