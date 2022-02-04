# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Staff::StudentsController', type: :request do
  let!(:student) { create(:student) }

  before do
    VCR.use_cassette('login') { post session_path }
    create(:admin, user: User.find_by_login('jpmagido'))
  end

  describe 'GET /index' do
    it 'returns http success' do
      get staff_students_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get staff_student_path(student)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_staff_student_path(student)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    let(:update_params) do
      {
        student: {
          description: 'rspec description',
          status: :ready
        }
      }
    end

    it 'returns http success' do
      patch staff_student_path(student), params: update_params
      expect(student.reload.description).to be_a ActionText::RichText
      expect(student.reload.ready?).to be_truthy
    end
  end
end
