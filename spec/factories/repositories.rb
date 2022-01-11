FactoryBot.define do
  factory :repository do
    github_url { FFaker::Internet.http_url }
    readme { FFaker::Book.description }
  end
end
