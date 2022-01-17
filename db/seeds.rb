# frozen_string_literal: true

def create_users(number = 10)
  FactoryBot.create_list(:user, number)
  puts "#{number} users are created"
end

def create_challenges(number = 10)
  challenges = FactoryBot.create_list(:challenge, number)
  challenges.each do |challenge|
    3.times do
      FactoryBot.create(:answer, challenge_id: challenge.id)
    end
  end
  puts "#{number} challenges created with each 3 answers each"
end

def perform
  create_users(20)
  create_challenges(15)
end

perform
