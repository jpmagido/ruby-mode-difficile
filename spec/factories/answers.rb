# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    github_url { FFaker::Internet.http_url }
    signature { FFaker::Book.author }
    status { rand(0..1) }
    comments { FFaker::Book.description }

    association :user
    association :challenge
  end
end
