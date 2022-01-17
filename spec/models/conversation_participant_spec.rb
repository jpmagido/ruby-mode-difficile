# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConversationParticipant, type: :model do
  let(:conversation_participant) { create(:conversation_participant) }

  it { expect(conversation_participant).to be_valid }
end
