# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Academy::StudentsController', type: :request do
  let(:current_user) { User.find_by_login('jpmagido') }

  before do
    VCR.use_cassette('login') { post session_path }
    create(:student, user: current_user, status: :ready)
  end

  describe 'GET /show' do
    it 'returns http success' do
      get academy_student_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_academy_student_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    let(:update_params) do
      {
        student: {
          status: :pending,
          description: 'rspec description'
        }
      }
    end

    it 'returns http success' do
      patch academy_student_path, params: update_params
      expect(current_user.student.description).to be_a ActionText::RichText
      expect(current_user.student.reload.pending?).to be_truthy
    end
  end

end
