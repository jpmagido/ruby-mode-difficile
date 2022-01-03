# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HttpService, type: :service do
  subject(:http_service_get) { described_class.new(get_url, params, headers) }
  let(:http_service_post) { described_class.new(post_url, params, headers) }

  let(:get_url) { 'https://httpbin.org/' }
  let(:post_url) { 'https://httpbin.org/post' }
  let(:params) { { name: 'test' } }
  let(:headers) { { 'Authorization': 'token: 123' } }

  describe '#new' do
    it { expect { http_service_get }.not_to raise_error }
  end

  describe '#get' do
    it { expect { http_service_get.get }.not_to raise_error }
  end

  describe '#post' do
    it { expect { http_service_post.post }.not_to raise_error }
  end

  describe '#build_url' do
    it { expect(http_service_get.build_url).to eq 'https://httpbin.org/?name=test' }
  end

  context 'fails input' do
    it { expect { described_class.new(10) }.to raise_error(ArgumentError) }
  end
end
