# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Github::Sync::UserSession, type: :service do
  subject(:sync_user_session) { described_class.new(token, request) }

  let(:token) { SecureRandom.hex 10 }
  let(:request) { Struct.new(:remote_ip) }

  describe '#new' do
    it { expect { sync_user_session }.not_to raise_error }
  end

  describe '#save_session!' do
    before { allow_any_instance_of(Github::Api).to receive(:find_user).and_return id: 123 }

    it { expect { sync_user_session.save_session! }.to change(User, :count).by 1 }
    it { expect { sync_user_session.save_session! }.to change(Session, :count).by 1 }
    it { expect(sync_user_session.save_session!).to eq Session.last.id }
  end

  context 'when wrong inputs' do
    it { expect { described_class.new(token, nil) }.to raise_error ArgumentError }
    it { expect { described_class.new(nil, request) }.to raise_error ArgumentError }
  end
end
