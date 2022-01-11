FactoryBot.define do
  factory :repository do
    github_url { FFaker::Internet.http_url }
    readme { FFaker::Book.description }

    association :cloud_storage, factory: %i[challenge answer].sample
  end
end
