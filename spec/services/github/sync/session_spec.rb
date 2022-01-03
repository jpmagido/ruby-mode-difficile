# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Github::Sync::Session, type: :service do
  subject(:sync_session) { described_class.new(github_user, request, token) }

  let(:github_user) { { id: 123 } }
  let(:request) { Struct.new(:remote_ip) }
  let(:token) { SecureRandom.hex 10 }
  let!(:user) { create(:user, github_id: 123) }
  let!(:session) { create(:session, user: user) }

  describe '#new' do
    it 'initializes properly' do
      expect { sync_session }.not_to raise_error
    end
  end

  describe '#build' do
    it 'builds proper session' do
      expect(subject.build).to be_an_instance_of Session
    end

    it 'destroys user_session' do
      expect { subject.build }.to change(Session, :count).by -1
    end
  end

  context 'errors' do
    it { expect { described_class.new(github_user, request, nil) }.to raise_error ArgumentError }
    it { expect { described_class.new(github_user, nil, token) }.to raise_error ArgumentError }
    it { expect { described_class.new({}, request, token) }.to raise_error ArgumentError }
  end
end
