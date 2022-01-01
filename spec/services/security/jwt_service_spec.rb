# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Security::JwtService do
  let(:encoder) { described_class.new(token: token) }
  let(:token) { SecureRandom.hex(10) }
  let(:wrong_input) { [[], :foobar, {}, 10, true] }
  let(:encoder_fail) { described_class.new(token: wrong_input.sample) }

  describe '#encode' do
    it { expect(encoder.encode).to be_a String }
  end

  describe '#decode' do
    it 'decodes properly' do
      expect(described_class.new(token: encoder.encode).decode).to eq token
    end
  end

  context 'fails input' do
    it { expect { encoder_fail }.to raise_error(ArgumentError) }
  end
end
