# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Github::Sync::User, type: :service do
  subject(:sync_user) { described_class.new(github_user) }

  let(:github_user) do
    {
      id: 123,
      login: 'my custom name',
      bio: 'I am tall',
      email: 'rspec@rspec.com',
      html_url: 'https://www.my_custom_url.com',
      avatar_url: 'https://www.my_avatar_url.com',
      blog: 'https://www.my_blog_url.com',
      followers: 10
    }
  end

  describe '#new' do
    it { expect { sync_user }.not_to raise_error }
  end

  describe '#synced_user' do
    it { expect(sync_user.synced_user).to be_a User }
    it { expect(sync_user.synced_user.github_id).to eq 123 }
    it { expect(sync_user.synced_user.login).to eq 'my custom name' }
    it { expect(sync_user.synced_user.bio).to eq 'I am tall' }
    it { expect(sync_user.synced_user.email).to eq 'rspec@rspec.com' }
    it { expect(sync_user.synced_user.html_url).to eq 'https://www.my_custom_url.com' }
    it { expect(sync_user.synced_user.avatar_url).to eq 'https://www.my_avatar_url.com' }
    it { expect(sync_user.synced_user.blog).to eq 'https://www.my_blog_url.com' }
    it { expect(sync_user.synced_user.followers).to eq 10 }

    context 'when User is banned' do
      let!(:banned_user) { create(:user, active: false, github_id: 123) }

      it 'raises unauthorized' do
        expect { sync_user.synced_user }.to raise_error described_class::Unauthorized
      end
    end
  end

  context 'when wrong inputs' do
    it { expect { described_class.new(id: nil) }.to raise_error ArgumentError }
    it { expect { described_class.new(followers: 10) }.to raise_error ArgumentError }
  end
end
