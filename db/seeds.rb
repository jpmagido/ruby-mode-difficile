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
  FactoryBot.create_list(:doc, 10, status: :ready)
            .each { |doc| FactoryBot.create(:doc_link, doc: doc) }

  p '10 Docs and their links have been created'
end

def doc_all_seed
  raise StandardError, 'unsafe production ENV' if Rails.env.production? && Doc.count >= 1

  Doc.destroy_all
  p 'all Doc destroyed'

  docs_info.each do |doc|
    Doc.create(title: doc[:title], tags: doc[:tags], content_fr: File.new(doc[:path], 'r').read)
  end

  "#{docs_info.count} Docs created"
end

def docs_info
  [
    {
      title: 'Testing',
      tags: 'test',
      path: Rails.root.join('db', 'docs_html', 'testing.html')
    },
    {
      title: 'Rspec',
      tags: 'test',
      path: Rails.root.join('db', 'docs_html', 'rspec.html')
    },
    {
      title: 'CSV',
      tags: 'format data',
      path: Rails.root.join('db', 'docs_html', 'csv.html')
    }
  ]
end

def perform
  destroy_all
  create_users(20)
  create_challenges(15)
  build if jpmagido_user
  seed_doc
end

perform
