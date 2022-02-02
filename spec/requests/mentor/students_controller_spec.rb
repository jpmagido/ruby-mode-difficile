# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Mentor::StudentsController', type: :request do
  before do
    VCR.use_cassette('login') { post session_path }
    create(:coach, user: User.find_by_login('jpmagido'), status: :ready)
  end

  let(:student) { create(:student) }

  describe 'GET /show' do
    it 'returns http success' do
      get mentor_student_path(student)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /index' do
    it 'returns http success' do
      get mentor_students_path
      expect(response).to have_http_status(:success)
    end
  end
end
