# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Github::Api::User, type: :service do
  subject(:github_api_user) { described_class.new(token) }

  let(:token) { SecureRandom.hex 10 }

  describe '#new' do
    it { expect { github_api_user }.not_to raise_error }
  end

  describe '#find_user' do
    xit do
      VCR.use_cassette('github-api-user-find_user') do
        expect(github_api_user.find_user).to eq 'lol'
      end
    end
  end

  context 'when errors' do
    it { expect { described_class.new(nil) }.to raise_error ArgumentError }
  end
end
