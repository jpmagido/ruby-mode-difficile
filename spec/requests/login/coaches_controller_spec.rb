# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login::CoachesController', type: :request do
  before { VCR.use_cassette('login') { post session_path } }

  let!(:admin) { create(:admin) }

  describe 'GET /new' do
    it 'returns http success' do
      get new_login_coach_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:create_params) { { coach: { message: 'bonjour' } } }

    it { expect { post login_coaches_path, params: create_params }.to change(Conversation, :count).by 1 }
    it { expect { post login_coaches_path, params: create_params }.to change(ConversationParticipant, :count).by 2 }
    it { expect { post login_coaches_path, params: create_params }.to change(ConversationMessage, :count).by 2 }
    it { expect { post login_coaches_path, params: create_params }.to change(Coach, :count).by 1 }
  end
end
