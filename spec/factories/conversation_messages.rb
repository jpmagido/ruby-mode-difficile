# frozen_string_literal: true

FactoryBot.define do


  factory :conversation_message do
    association :conversation
    association :conversation_participant
  end
end
