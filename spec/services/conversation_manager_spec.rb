# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConversationManager do
  subject(:conversation_manager) { described_class.new(create_list(:user, 3)) }

  it { expect { subject }.not_to raise_error }
  it { expect { subject.find_conversation }.not_to raise_error }

  context 'conversation with all participants does not exist yet' do
    it 'creates 3 participants' do
      expect(ConversationParticipant.count).to eq 0
      conversation_manager.find_conversation
      expect(ConversationParticipant.count).to eq 3
    end

    it 'creates 1 conversation' do
      expect(Conversation.count).to eq 0
      conversation_manager.find_conversation
      expect(Conversation.count).to eq 1
    end

    it { expect(conversation_manager.find_conversation).to be_a Conversation }
  end

  context 'conversation with all participants already exists' do
    let!(:conversation) { create(:conversation) }
    let(:conversation_manager_bis) { described_class.new(conversation.conversation_participants.map(&:user)) }

    it 'does not create conversation' do
      expect(Conversation.count).to eq 1
      conversation_manager_bis.find_conversation
      expect(Conversation.count).to eq 1
    end

    it 'does not create conversation' do
      expect(ConversationParticipant.count).to eq 2
      conversation_manager_bis.find_conversation
      expect(ConversationParticipant.count).to eq 2
    end
  end
end
