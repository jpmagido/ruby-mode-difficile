# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConversationMessage, type: :model do
  let(:conversation_message) { create(:conversation_message) }

  it { expect(conversation_message).to be_valid }
end
