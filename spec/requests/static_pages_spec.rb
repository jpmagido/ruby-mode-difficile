require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  describe 'GET /root' do
    it 'returns http success' do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /contact' do
    it 'returns http success' do
      get static_pages_contact_path
      expect(response).to have_http_status(:success)
    end
  end
end
