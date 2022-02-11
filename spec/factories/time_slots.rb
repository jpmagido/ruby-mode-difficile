# frozen_string_literal: true

FactoryBot.define do
  factory :time_slot do
    start_date { FFaker::Time.datetime }
    end_date { FFaker::Time.datetime }

    coach_approval { false }
    student_approval { false }

    association :mentorship_session
  end
end
