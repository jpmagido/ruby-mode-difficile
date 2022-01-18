# frozen_string_literal: true

FactoryBot.define do
  factory :conversation_message do
    content { FFaker::Book.description }
    read { [true, false].sample }

    association :conversation
    association :conversation_participant
  end
end
