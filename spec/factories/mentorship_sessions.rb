# frozen_string_literal: true

FactoryBot.define do
  factory :mentorship_session do
    start_date { FFaker::Time.date }
    end_date { FFaker::Time.date }

    association :mentorship
  end
end
