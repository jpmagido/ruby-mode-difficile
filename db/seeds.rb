def create_users
    FactoryBot.create_list(:user, 10,
                            login: FFaker::Internet.user_name,
                            email: FFaker::Internet.email)
    puts '10 users are created'    
end

def create_answers
    return FactoryBot.create_list(:answer, 3, 
                                            github_url: FFaker::Internet.http_url,
                                            signature: FFaker::Lorem.characters(character_count = 16),
                                            comments: FFaker::Lorem.paragraphs(paragraph_count = 3))   
end

def create_challenges
    created_challenges = FactoryBot.create_list(:challenge, 10,
                                                description: FFaker::Lorem.paragraph(sentence_count = 4),
                                                title: FFaker::Lorem.sentence(word_count = 4),
                                                url: FFaker::Internet.http_url,
                                                duration: [30,45,60,120].sample,
                                                difficulty: [1,2,3,4,5].sample,
                                                signature: FFaker::Lorem.characters(character_count = 16),
                                                user: User.all.sample)
    puts '10 challenges created with each 3 answers'        
end

def add_answers_to_challeges
    answers = create_answers
    Challenge.all.each do |challenge|
        answers.each do |answer|
           challenge.answers << answer
        end
    end
end

def perform
    create_users
    create_challenges
    add_answers_to_challeges
end


perform()