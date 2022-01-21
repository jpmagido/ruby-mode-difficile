# frozen_string_literal: true

FactoryBot.define do
  factory :doc_link do
    association :doc
    association :linkable, factory: %i[challenge answer].sample
  end
end
