# frozen_string_literal: true

FactoryBot.define do
  factory :mentorship_session do
    start_date { DateTime.now }
    end_date { DateTime.now + 1 }

    association :mentorship
  end
end
