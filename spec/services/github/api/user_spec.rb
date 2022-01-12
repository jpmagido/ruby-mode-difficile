# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Github::Api::User, type: :service do
  subject(:github_api_user) { described_class.new(token) }

  let(:token) { 'fake token' }

  describe '#new' do
    it { expect { github_api_user }.not_to raise_error }
  end

  describe '#find_user' do
    it 'returns proper information' do
      VCR.use_cassette('github-api-user-find_user') do
        response = github_api_user.find_user

        expect(response['id']).to eq 48_461_607
        expect(response['login']).to eq 'jpmagido'
      end
    end
  end

  context 'when errors' do
    it { expect { described_class.new(nil) }.to raise_error ArgumentError }
  end
end
