# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Staff::DocLinksController', type: :request do
  let!(:challenge) { create(:challenge) }
  let!(:answer) { create(:answer) }
  let!(:doc) { create(:doc) }
  let(:doc_link) { create(:doc_link) }

  before do
    VCR.use_cassette('login') { post session_path }
    create(:admin, user: User.find_by_login('jpmagido'))
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_staff_doc_link_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:create_params_challenge) do
      {
        doc_link: {
          linkable: "Challenge/#{challenge.id}",
          doc_id: doc.id
        }
      }
    end

    let(:create_params_answer) do
      {
        doc_link: {
          linkable: "Answer/#{answer.id}",
          doc_id: doc.id
        }
      }
    end

    it 'creates a new DocLink' do
      expect { post staff_doc_links_path, params: [create_params_challenge, create_params_answer].sample }
        .to change { DocLink.count }.by 1
    end
  end

  describe 'DELETE /destroy' do
    it 'creates a new DocLink' do
      doc_link
      expect { delete staff_doc_link_path(doc_link) }.to change { DocLink.count }.by(-1)
    end
  end
end
