# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Session, type: :model do
  let!(:session) { create(:session, token: token) }
  let(:token) { SecureRandom.hex 10 }
  let!(:saved_session) { create(:session) }

  it { expect(session).to be_valid }

  describe '#save' do
    xit { session.save! }
  end

  describe '#token' do
    it 'returns decoded token' do
      expect(session.token).to eq token
    end
  end
end
