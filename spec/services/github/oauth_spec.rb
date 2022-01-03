# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Github::Oauth, type: :service do
  subject(:github_oauth) { described_class.new(params) }

  let(:params) { { username: 'test_user' } }

  describe '#new' do
    it { expect { github_oauth }.not_to raise_error }
  end

  describe '#oauth_production' do
    xit { expect(github_oauth.oauth_production).to eq 'lol' }
  end

  context 'when errors' do
    it { expect { described_class.new({}) }.to raise_error ArgumentError }
    it { expect { described_class.new(id: 123) }.to raise_error ArgumentError }
    it { expect { described_class.new(username: nil) }.to raise_error ArgumentError }
  end
end
