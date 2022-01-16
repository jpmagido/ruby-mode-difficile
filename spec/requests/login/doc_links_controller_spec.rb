# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login::DocLinksController', type: :request do
  let(:challenge) { create(:challenge, user: current_user) }
  let(:answer) { create(:answer, user: current_user) }
  let(:doc) { create(:doc) }
  let(:current_user) { User.find_by_login('jpmagido') }

  before { VCR.use_cassette('login') { post session_path } }

  describe 'GET /new' do
    it 'returns http success' do
      get new_login_doc_link_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'when current_user add doc to his Challenge or Answer' do
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
        expect { post login_doc_links_path, params: [create_params_challenge, create_params_answer].sample }
          .to change { DocLink.count }.by 1
      end
    end

    context 'when current_user add doc to other user Challenge or Answer' do
      let(:params_challenge) do
        {
          doc_link: {
            linkable: "Challenge/#{create(:challenge).id}",
            doc_id: doc.id
          }
        }
      end

      let(:params_answer) do
        {
          doc_link: {
            linkable: "Answer/#{create(:answer).id}",
            doc_id: doc.id
          }
        }
      end

      it 'creates a new DocLink' do
        expect { post login_doc_links_path, params: params_challenge }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end
end
