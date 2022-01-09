# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Staff::AdminsController', type: :request do
  before { VCR.use_cassette('login') { post session_path } }

  context 'when current_user is Admin' do
    before { create(:admin, user: User.last) }

    it 'returns http success' do
      get staff_admin_path
      expect(response).to have_http_status(:success)
    end
  end

  context 'when current_user is not Admin' do
    it { expect(get(staff_admin_path)).to redirect_to(root_path) }
  end
end
