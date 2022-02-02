# frozen_string_literal: true

FactoryBot.define do
  factory :mentorship do
    coach_approval { false }
    student_approval { false }
    association :student
    association :coach
  end
end
