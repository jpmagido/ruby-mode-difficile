# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Mentor::MentorshipsController', type: :request do
  before do
    VCR.use_cassette('login') { post session_path }
    create(:coach, user: current_user, status: :ready)
  end

  let(:current_user) { User.find_by_login('jpmagido') }
  let!(:mentorship) { create(:mentorship, coach: current_user.coach) }
  let(:student) { create(:student) }

  describe 'GET /index' do
    it 'returns http success' do
      get mentor_mentorships_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get mentor_mentorship_path(mentorship)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_mentor_mentorship_path(mentorship)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'creates a new Mentorship' do
      expect { post mentor_mentorships_path(student_id: student.id) }
        .to change(Mentorship, :count).by 1
    end
  end

  describe 'PATCH /update' do
    let(:update_params) do
      {
        mentorship: {
          coach_approval: true
        }
      }
    end

    it 'updates Mentorship' do
      patch mentor_mentorship_path(mentorship), params: update_params
      expect(mentorship.reload.coach_approval).to be_truthy
    end
  end
end
