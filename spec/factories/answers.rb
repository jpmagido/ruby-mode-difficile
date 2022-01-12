# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    youtube_url { FFaker::Internet.http_url }
    signature { FFaker::Book.author }
    status { :pending }
    comments { FFaker::Book.description }

    association :user
    association :challenge

    after(:create) do |answer|
      create(:repository, cloud_storage: answer)
    end
  end
end
