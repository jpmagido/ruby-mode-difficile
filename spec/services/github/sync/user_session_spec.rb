# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Github::Sync::UserSession, type: :service do
  subject(:sync_user_session) { described_class.new(token, request) }

  let(:token) { 'fake token' }
  let(:request) { Struct.new(:remote_ip) }

  describe '#new' do
    it { expect { sync_user_session }.not_to raise_error }
  end

  describe '#save_session!' do
    it 'creates a User' do
      VCR.use_cassette('ip-check') do
        expect { sync_user_session.save_session! }.to change(User, :count).by 1
      end
    end

    it 'creates a Session' do
      VCR.use_cassette('ip-check') do
        expect { sync_user_session.save_session! }.to change(Session, :count).by 1
      end
    end

    it 'returns session ID' do
      VCR.use_cassette('ip-check') do
        expect(sync_user_session.save_session!).to eq Session.last.id
      end
    end
  end

  context 'when wrong inputs' do
    it { expect { described_class.new(token, nil) }.to raise_error ArgumentError }
    it { expect { described_class.new(nil, request) }.to raise_error ArgumentError }
  end
end
