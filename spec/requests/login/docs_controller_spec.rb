# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login::DocsController', type: :request do
  let(:doc) { create(:doc) }

  before { VCR.use_cassette('login') { post session_path } }

  describe 'GET /index' do
    it 'returns http success' do
      get login_docs_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get login_doc_path(doc)
      expect(response).to have_http_status(:success)
    end
  end
end
