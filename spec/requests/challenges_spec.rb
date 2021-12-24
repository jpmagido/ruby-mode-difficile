require 'rails_helper'

RSpec.describe 'Challenges', type: :request do
  let(:challenge) { create(:challenge) }

  describe 'GET /index' do
    it 'returns http success' do
      get challenges_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get challenge_path(challenge)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_challenge_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:challenge_params) do
      {
        title: 'title test',
        description: 'test description',
        duration: 20,
        difficulty: 3,
        signature: 'jpm',
        url: 'https://www.google.fr',
      }
    end

    context 'when success' do
      it 'redirects to show' do
        post challenges_path, params: { challenge: challenge_params }
        expect(response).to redirect_to challenge_path(Challenge.last)
      end
    end

    context 'when error' do
      it 'renders new' do
        post challenges_path, params: { challenge: { title: '' } }
        expect(response).to render_template :new
      end
    end
  end
end
