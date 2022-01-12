# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login::AnswersController', type: :request do
  before { VCR.use_cassette('login') { post session_path } }

  let!(:challenge) { create(:challenge) }
  let!(:random_answer) { create(:answer) }
  let!(:answer) { create(:answer, challenge: challenge) }
  let!(:verified_answer) { create(:answer, challenge: challenge, status: :ready, user: current_user) }
  let!(:current_user_answer) { create(:answer, challenge: challenge, user: current_user) }
  let(:current_user) { User.find_by_login('jpmagido') }

  describe 'GET /show' do
    it 'raises error if current user is not author' do
      expect { get login_challenge_answer_path(random_answer.challenge, random_answer) }.to raise_error Pundit::NotAuthorizedError
    end

    it 'returns http success if current user is author' do
      get login_challenge_answer_path(challenge, current_user_answer)
      expect(response).to have_http_status(:success)
    end

    it 'returns http success if current user has already resolved the answers challenge' do
      get login_challenge_answer_path(challenge, answer)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_login_challenge_answer_path(challenge)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:post_params) do
      {
        answer: {
          youtube_url: 'https://youtube.com',
          signature: 'user rspec',
          comments: 'this is an rspec test',
          repository: { github_url: 'https://github.com' }
        }
      }
    end

    it 'creates an Answer' do
      expect { post login_challenge_answers_path(challenge), params: post_params }.to change(Answer, :count).by 1
    end

    it 'creates a Repository' do
      expect { post login_challenge_answers_path(challenge), params: post_params }.to change(Repository, :count).by 1
    end
  end
end
