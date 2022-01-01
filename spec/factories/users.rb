FactoryBot.define do
  factory :user do
    github_id { rand(100..10000) }
    login { FFaker::Book.title }
    email { FFaker::Internet.email }
    bio { FFaker::Book.description }
    repos_url { FFaker::Internet.http_url }
    avatar_url { FFaker::Internet.http_url }
    blog { FFaker::Internet.http_url }
    repos_count { rand(1..100) }
    followers { rand(1..100) }
    language { 0 }
  end
end
