# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Github::Api::Repository, type: :service do
  subject(:github_api_readme) { described_class.new(owner_name: 'jpmagido', repo_name: 'movie_finder') }

  let(:token) { SecureRandom.hex 10 }

  describe '#new' do
    it { expect { github_api_readme }.not_to raise_error }
  end

  describe '#readme' do
    xit 'fetches readme content' do
      VCR.use_cassette('fetch-readme') do
        expect(github_api_readme.readme).to eq 'lol'
      end
    end
  end

  context 'when errors' do
    let(:random_wrong_input) { [true, 1, :foo, nil, 1.1].sample }

    it 'raises argument error' do
      expect { described_class.new(owner_name: random_wrong_input, repo_name: random_wrong_input) }
        .to raise_error ArgumentError
    end
  end
end
