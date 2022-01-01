# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login::UsersController', type: :request do
  describe 'GET /show' do
    let(:user) { build(:user) }
    let(:session) { build(:session, user: user) }

    before do
      user.save!
      session.save!
    end

    xit 'returns http success' do
      get(user_path, params: {}, session: { user_session_id: session.id })
      expect(response).to have_http_status(:success)
    end
  end
end
