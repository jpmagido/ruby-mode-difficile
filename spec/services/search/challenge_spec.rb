# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Search::Challenge, type: :service do
  let(:search_challenge) { described_class.new(Challenge.all, {}) }

  it { expect { search_challenge }.not_to raise_error }
  it { expect(search_challenge.search).to be_an ActiveRecord::Relation }

  context 'Search with parameters' do
    let!(:user) { create(:user) }
    let!(:student) { create(:user) }
    let!(:doc) { create(:doc) }
    let!(:doc_link) { create(:doc_link, doc: doc, linkable: challenge) }

    let!(:challenge) { create(:challenge, title: 'test', user: user, difficulty: 5, duration: 100) }
    let!(:challenge_bis) { create(:challenge, difficulty: 1, duration: 300) }

    it 'finds Challenge with proper Title' do
      search = described_class.new(Challenge.all, title: 'Test').search

      expect(search).to include challenge
      expect(search).not_to include challenge_bis
    end

    it 'finds Challenge with proper Author' do
      search = described_class.new(Challenge.all, user_id: user.id).search

      expect(search).to include challenge
      expect(search).not_to include challenge_bis
    end

    it 'finds Challenge with proper Doc' do
      search = described_class.new(Challenge.all, doc_id: doc.id).search

      expect(search).to include challenge
      expect(search).not_to include challenge_bis
    end

    it 'finds Challenge with proper Difficulty' do
      search = described_class.new(Challenge.all, difficulty: 5).search

      expect(search).to include challenge
      expect(search).not_to include challenge_bis
    end

    it 'finds Challenge with proper duration min' do
      search = described_class.new(Challenge.all, duration_min: 25).search

      expect(search).to include challenge
    end

    it 'finds Challenge with proper duration max' do
      search = described_class.new(Challenge.all, duration_max: 200).search

      expect(search).to include challenge
      expect(search).not_to include challenge_bis
    end

    it 'finds Challenge with proper params' do
      params = { title: 'test', user_id: user.id, doc_id: doc.id, difficulty: 5, duration_min: 20, duration_max: 200 }
      search = described_class.new(Challenge.all, params).search

      expect(search).to include challenge
      expect(search).not_to include challenge_bis
    end
  end
end
