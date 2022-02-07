# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Mentor::MentorshipSessionsController', type: :request do
  let(:mentorship_session) { create(:mentorship_session, mentorship: create(:mentorship, coach: current_user.coach)) }
  let(:mentorship) { create(:mentorship) }
  let(:today) { Date.today }
  let(:current_user) { User.find_by_login('jpmagido') }

  before do
    VCR.use_cassette('login') { post session_path }
    create(:coach, user: current_user, status: :ready)
  end

  describe 'GET /index' do
    it 'returns http success' do
      get mentor_mentorship_sessions_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get mentor_mentorship_session_path mentorship_session
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_mentor_mentorship_session_path, params: { mentorship_session_id: mentorship_session.mentorship_id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:create_params) do
      {
        mentorship_session: {
          start_date: today,
          end_date: today + 1,
          mentorship_id: mentorship.id
        }
      }
    end

    it 'creates a new MentorshipSession' do
      expect { post mentor_mentorship_sessions_path, params: create_params }.to change(MentorshipSession, :count).by 1
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_mentor_mentorship_path(mentorship_session)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:update_params) do
      {
        mentorship_session: {
          start_date: today,
          end_date: today + 1
        }
      }
    end

    it 'creates a new MentorshipSession' do
      expect { patch mentor_mentorship_session_path(mentorship_session), params: update_params }
        .to change(mentorship_session.reload, :start_date).to today
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the record' do
      expect { delete mentor_mentorship_session_path(mentorship_session) }.to change(MentorshipSession, :count).by(-1)
    end
  end
end
