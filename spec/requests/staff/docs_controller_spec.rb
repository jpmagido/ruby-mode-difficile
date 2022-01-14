# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Staff::DocsController', type: :request do
  let(:doc) { create(:doc) }

  before do
    VCR.use_cassette('login') { post session_path }
    create(:admin, user: User.find_by_login('jpmagido'))
  end

  describe 'GET /index' do
    it 'returns http success' do
      get staff_docs_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get staff_doc_path(doc)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_staff_doc_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_staff_doc_path(doc)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:create_params) { { doc: { title: 'foobar-title', tags: '#foo', content: '<p> foobar </p>' } } }

    it { expect { post staff_docs_path, params: create_params }.to change(Doc, :count).by 1 }
  end

  describe 'PATCH /update' do
    let(:update_params) { { doc: { title: 'foobar-title', tags: '#foo', content: '<p> foobar </p>' } } }

    it { expect { patch staff_doc_path(doc), params: update_params }.to change { doc.reload.title }.to('foobar-title') }
  end

  describe 'DELETE /destroy' do
    it 'destroys doc record' do
      doc
      expect { delete staff_doc_path(doc) }.to change { Doc.count }.by(-1)
    end
  end
end
