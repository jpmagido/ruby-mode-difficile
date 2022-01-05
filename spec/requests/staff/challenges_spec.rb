# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Staff::ChallengesController', type: :request do
  let!(:challenge) { create(:challenge) }

  before do
    post session_path
    create(:admin, user: User.last)
  end

  describe 'GET /index' do
    it 'returns http success' do
      get staff_challenges_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get staff_challenge_path(challenge)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_staff_challenge_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:challenge_params) do
      {
        title: 'title test',
        status: :ready,
        duration: 20,
        difficulty: 3,
        signature: 'jpm',
        url: 'https://www.google.fr',
        description: 'test description',
      }
    end

    context 'when success' do
      it 'creates a Challenge' do
        expect { post staff_challenges_path, params: { challenge: challenge_params } }
          .to change(Challenge, :count).by 1
      end
    end

    context 'when error' do
      it 'renders new' do
        post staff_challenges_path, params: { challenge: { title: '' } }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_staff_challenge_path(challenge)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /edit' do
    it 'updates challenge' do
      patch staff_challenge_path(challenge), params: { challenge: { title: 'new title' } }

      expect(challenge.reload.title).to eq 'new title'
    end
  end

  describe 'DELETE /destroy' do
    it 'delete challenge' do
      expect { delete staff_challenge_path(challenge) }.to change(Challenge, :count).by(-1)
    end

    it 'redirects to' do
      delete staff_challenge_path(challenge)
      expect(response).to redirect_to staff_challenges_path
    end
  end
end
