# frozen_string_literal: true

def destroy_all
  [Answer, Challenge, Coach, Admin, Mentorship, MentorshipSession, DocLink, Doc].each(&:destroy_all)
end

def create_users(number = 10)
  FactoryBot.create_list(:user, number)
  puts "#{number} users are created"
end

def create_challenges(number = 10)
  FactoryBot.create_list(:challenge, number, status: :ready).each do |challenge|
    3.times { FactoryBot.create(:answer, challenge: challenge) }
  end
  puts "#{number} challenges created with each 3 answers each"
end

def perform
  create_users(20)
  create_challenges(15)
end

def jpmagido_user
  User.where.not(login: 'jpmagido').destroy_all
  User.find_by_login('jpmagido')
end

def build
  FactoryBot.create(:coach, status: :ready, user: jpmagido_user)
  FactoryBot.create(:admin, user: jpmagido_user)

  mentorship = FactoryBot.create(:mentorship, coach: jpmagido_user.coach)
  FactoryBot.create(:mentorship_session, mentorship: mentorship)

  p 'User jpmagido is now Admin & Coach'
end

def seed_doc
  FactoryBot.create_list(:doc_link, 10)

  p '10 Docs and their links have been created'
end

destroy_all
build if jpmagido_user
seed_doc
perform
