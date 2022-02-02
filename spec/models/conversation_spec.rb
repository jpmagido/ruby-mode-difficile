# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Conversation, type: :model do
  let(:conversation) { create(:conversation) }

  it { expect(conversation).to be_valid }
end
