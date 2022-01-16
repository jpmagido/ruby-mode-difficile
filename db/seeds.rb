# frozen_string_literal: true

def create_users
  FactoryBot.create_list(:user, 10)
  puts '10 users are created'    
end

def create_challenges
  challenges = FactoryBot.create_list(:challenge, 10)
  challenges.each do |challenge|
    3.times do
      FactoryBot.create(:answer,challenge_id: challenge.id)
    end
  end
  puts '10 challenges created with each 3 answers'        
end

def perform
  create_users
  create_challenges
end

perform
