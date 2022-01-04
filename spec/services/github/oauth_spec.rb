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
    let(:wrong_inputs) { [true, '', [], nil, 0, 0.1, :foobar, Struct.new(:foo)] }

    it { expect { described_class.new(wrong_inputs.sample) }.to raise_error ArgumentError }
  end
end
