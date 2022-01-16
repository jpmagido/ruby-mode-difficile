# frozen_string_literal: true

FactoryBot.define do
  factory :doc do
    title { FFaker::Book.title }
    tags { 'foo bar foobar' }
    status { :pending }
    content { FFaker::Book.description }
  end
end
