# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Search::MentorshipSession, type: :service do
  let(:search_mentorship_session) { described_class.new(MentorshipSession.all, {}) }

  it { expect { search_mentorship_session }.not_to raise_error }
  it { expect(search_mentorship_session.search).to be_an ActiveRecord::Relation }

  context 'Search with parameters' do
    let(:mentorship_session) { create(:mentorship_session, start_date: DateTime.now, end_date: DateTime.now + 1) }
    let(:outdated_mentorship_session_1) { create(:mentorship_session, start_date: DateTime.now, end_date: DateTime.now + 3) }
    let(:outdated_mentorship_session_2) { create(:mentorship_session, start_date: DateTime.now - 3, end_date: DateTime.now + 1) }

    let(:mentorship_search) { described_class.new(MentorshipSession.all, params) }
    let(:params) { { start_date: DateTime.now - 2, end_date: DateTime.now + 2 } }

    it 'includes proper Mentorship Sessions' do
      expect(mentorship_search.search).to include(mentorship_session)
      expect(mentorship_search.search).not_to include(outdated_mentorship_session_1)
      expect(mentorship_search.search).not_to include(outdated_mentorship_session_2)
    end
  end
end
