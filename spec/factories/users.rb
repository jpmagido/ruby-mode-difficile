FactoryBot.define do
  factory :user do
    name { "MyString" }
    github_url { "MyText" }
    avatar_url { "MyText" }
    personal_url { "MyText" }
    biography { "MyText" }
    repos_count { 1 }
    followers { 1 }
    github_id { 1 }
  end
end
