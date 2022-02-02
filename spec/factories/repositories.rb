# frozen_string_literal: true

FactoryBot.define do
  factory :repository do
    github_url { 'https://github.com/jpmagido/movie_finder' }
    readme { FFaker::Book.description }

    association :cloud_storage, factory: %i[challenge answer].sample
  end
end
