# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Linkedin::Sync::LinkedinSession, type: :service do
  subject(:syncer) { described_class.new(user, linkedin_token) }

  let(:user) { create(:user) }
  let(:linkedin_token) { SecureRandom.hex(5) }
  let!(:previous_linkedin_session) { create(:linkedin_session, user: user) }

  it { expect(syncer.sync).to be_truthy }

  it 'creates new linkedin Session' do
    syncer.sync
    expect(user.reload.linkedin_session.token).to eq linkedin_token
  end

  it 'destroys previous linkedin_session' do
    syncer.sync
    expect(LinkedinSession.find_by(id: previous_linkedin_session.id)).to be_nil
  end

  context 'when raises' do
    it 'returns false ' do
      expect(syncer.sync).to be_falsey
    end

    it 'does not create new linkedin Session' do
      syncer.sync
      allow(:user).to receive(:id).and_return(1)
      expect(user.reload.linkedin_session.token).to eq previous_linkedin_session.token
    end
  end
end
