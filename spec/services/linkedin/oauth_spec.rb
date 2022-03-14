# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Linkedin::Oauth, type: :service do
  let(:oauth_step1) { described_class.new(state: ENV['LINKEDIN_REDIRECT_TOKEN']).step_1 }
  let(:oauth_step2) { described_class.new(code).step_2 }
  let(:code) { { code: 'lol' } }

  describe '#initialize' do
    it { expect { described_class.new(state: ENV['LINKEDIN_REDIRECT_TOKEN']) }.not_to raise_error }
    it { expect { described_class.new(true) }.to raise_error(ArgumentError, 'params must be a Hash') }
  end

  describe '#step_1' do
    it { expect(oauth_step1).to match(/https/) }
  end

  describe '#step_2' do
    xit 'raises not' do
      VCR.use_cassette('linkedin-login') do
        expect(oauth_step2).to eq 'lol'
      end
    end
  end
end
