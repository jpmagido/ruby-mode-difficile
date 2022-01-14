# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Staff::ChallengeDocs', type: :request do
  let!(:challenge) { create(:challenge) }
  let!(:doc) { create(:doc) }
  let(:challenge_doc) { create(:challenge_doc) }

  before do
    VCR.use_cassette('login') { post session_path }
    create(:admin, user: User.find_by_login('jpmagido'))
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_staff_challenge_doc_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:create_params) do
      {
        challenge_doc: {
          challenge_id: challenge.id,
          doc_id: doc.id
        }
      }
    end

    it 'creates a new ChallengeDoc' do
      expect { post staff_challenge_docs_path, params: create_params }.to change { ChallengeDoc.count }.by 1
    end
  end

  describe 'DELETE /destroy' do
    it 'creates a new ChallengeDoc' do
      challenge_doc
      expect { delete staff_challenge_doc_path(challenge_doc) }.to change { ChallengeDoc.count }.by(-1)
    end
  end
end
