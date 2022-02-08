# frozen_string_literal: true

FactoryBot.define do
  factory :mentorship_session do
    start_date { Date.today }
    end_date { Date.today + 1 }

    association :mentorship
  end
end
