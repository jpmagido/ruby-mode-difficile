# frozen_string_literal: true

FactoryBot.define do
  factory :conversation do
    after :create do |conversation|
      create_list(:conversation_participant, 2, conversation: conversation)
    end
  end
end
