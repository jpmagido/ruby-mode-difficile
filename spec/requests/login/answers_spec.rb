# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login::AnswersController', type: :request do
  let!(:challenge) { create(:challenge) }
  let!(:answers) { create_list(:answer, 3, challenge: challenge) }

  before { post session_path }

  describe 'GET /index' do
    it 'returns http success' do
      get login_challenge_answers_path(challenge)
      expect(response).to have_http_status(:success)
    end
  end

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
end
