# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login::AnswersController', type: :request do
  let!(:challenge) { create(:challenge) }
  let!(:answers) { create_list(:answer, 3, challenge: challenge) }

  before { post session_path }

  describe 'GET /show' do
    it 'returns http success' do
      get login_challenge_answer_path(challenge, answers.first)
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
          github_url: 'https://github.com',
          youtube_url: 'https://youtube.com',
          signature: 'user rspec',
          comments: 'this is an rspec test'
        }
      }
    end

    it 'creates an Answer' do
      expect { post login_challenge_answers_path(challenge), params: post_params }.to change(Answer, :count).by 1
    end
  end
end
