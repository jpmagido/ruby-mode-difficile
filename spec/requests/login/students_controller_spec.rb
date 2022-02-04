# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login::StudentsController', type: :request do
  let(:current_user) { User.find_by_login('jpmagido') }

  before { VCR.use_cassette('login') { post session_path } }

  describe 'GET /new' do
    it 'returns http success' do
      get new_login_student_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:create_params) do
      {
        student: {
          description: 'rspec description'
        }
      }
    end

    it 'creates a Student for current_user' do
      expect(current_user.student).to be_nil
      post login_students_path, params: create_params
      expect(current_user.reload.student).not_to be_nil
    end
  end
end
