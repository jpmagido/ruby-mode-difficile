# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login::ConversationsController', type: :request do
  let(:conversation) { create(:conversation) }
  let(:current_user) { User.find_by_login('jpmagido') }
  let(:current_user_participant) { create(:conversation_participant, conversation: conversation, user: current_user) }

  before { VCR.use_cassette('login') { post session_path } }

  describe 'GET /show' do
    it 'returns http success' do
      get login_conversation_path(0)
      expect(response).to have_http_status(:success)
    end

    it 'returns http success' do
      current_user_participant
      get login_conversation_path(conversation)
      expect(response).to have_http_status(:success)
    end

    it 'raises unauthorized pundit' do
      expect { get login_conversation_path(create(:conversation)) }.to raise_error Pundit::NotAuthorizedError
    end
  end
end
