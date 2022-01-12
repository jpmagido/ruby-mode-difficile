# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login::ChallengesController', type: :request do
  let(:challenge) { create(:challenge) }

  before { VCR.use_cassette('login') { post session_path } }

  describe 'GET /index' do
    it 'returns http success' do
      get login_challenges_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get login_challenge_path(challenge)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_login_challenge_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:challenge_params) do
      {
        challenge: {
          title: 'title test',
          duration: 20,
          difficulty: 3,
          signature: 'jpm',
          github_url: 'https://www.google.fr',
          description: 'test description',
        }
      }
    end

    context 'when success' do
      it 'creates a Challenge' do
        expect { post login_challenges_path, params: challenge_params }
          .to change(Challenge, :count).by 1
      end

      it 'redirects to show' do
        post login_challenges_path, params: challenge_params
        expect(response).to redirect_to login_challenge_path(Challenge.last)
      end

      it 'creates Challenge' do
        expect { post login_challenges_path, params: challenge_params }.to change(Challenge, :count).by 1
      end

      it 'creates Repository' do
        expect { post login_challenges_path, params: challenge_params }.to change(Repository, :count).by 1
      end
    end

    context 'when error' do
      it 'renders new' do
        post login_challenges_path, params: { challenge: { title: '' } }
        expect(response).to render_template :new
      end
    end
  end
end
