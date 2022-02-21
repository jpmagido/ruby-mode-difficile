# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    github_id { rand(100..10000) }
    login { FFaker::NameFR.first_name }
    email { FFaker::Internet.email }
    bio { FFaker::Book.description }
    html_url { FFaker::Internet.http_url }
    avatar_url { FFaker::Internet.http_url }
    blog { FFaker::Internet.http_url }
    followers { rand(1..100) }
    language { :fr }
    active { true }
  end
end
