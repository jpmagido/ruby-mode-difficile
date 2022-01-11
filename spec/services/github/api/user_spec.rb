# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Github::Api::User, type: :service do
  subject(:github_api) { described_class.new(token) }

  let(:token) { SecureRandom.hex 10 }

  describe '#new' do
    it { expect { github_api }.not_to raise_error }
  end

  describe '#find_user' do
    xit { expect(github_api.find_user).to eq 'lol' }
  end

  context 'when errors' do
    it { expect { described_class.new(nil) }.to raise_error ArgumentError }
  end
end
