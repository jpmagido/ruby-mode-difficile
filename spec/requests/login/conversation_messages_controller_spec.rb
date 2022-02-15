# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login::ConversationMessagesController', type: :request do
  let(:conversation) { create(:conversation) }
  let(:conversation_message) { create(:conversation_message) }
  let(:current_user) { User.find_by_login('jpmagido') }
  let(:current_user_participant) { create(:conversation_participant, conversation: conversation, user: current_user) }

  before { VCR.use_cassette('login') { post session_path } }

  describe 'GET /new' do
    it 'returns http success' do
      get new_login_conversation_conversation_message_path(conversation_message.conversation, conversation_message)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:create_params) { { conversation_message: { content: 'rspec message' } } }

    it 'creates a message' do
      current_user_participant
      expect { post login_conversation_conversation_messages_path(conversation), params: create_params }
        .to change(ConversationMessage, :count).by 1
    end
  end
end
