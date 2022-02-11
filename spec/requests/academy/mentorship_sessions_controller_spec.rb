# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Academy::MentorshipSessionsController', type: :request do
  let(:current_user) { User.find_by_login('jpmagido') }
  let(:mentorship_session) { create(:mentorship_session, mentorship: create(:mentorship, student: current_user.student)) }
  let(:mentorship) { create(:mentorship, student: current_user.student) }
  let(:today) { Date.today }

  before do
    VCR.use_cassette('login') { post session_path }
    create(:student, user: current_user, status: :ready)
  end

  describe 'GET /index' do
    it 'returns http success' do
      get academy_mentorship_sessions_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get academy_mentorship_session_path(mentorship_session)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_academy_mentorship_session_path, params: { mentorship_id: mentorship.id }
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

    it 'creates mentorship_session' do
      expect(MentorshipSession.count).to eq 0
      post academy_mentorship_sessions_path, params: create_params
      expect(MentorshipSession.count).to eq 1
    end

    it 'creates ConversationMessage' do
      expect(MentorshipSession.count).to eq 0
      post academy_mentorship_sessions_path, params: create_params
      expect(ConversationMessage.count).to eq 1
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_academy_mentorship_session_path(mentorship_session)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    let(:update_params) do
      {
        mentorship_session: {
          start_date: today + 3,
          end_date: today + 4
        }
      }
    end

    it 'updates mentorship_session' do
      expect(mentorship_session.start_date).to eq today
      patch academy_mentorship_session_path(mentorship_session), params: update_params
      expect(mentorship_session.reload.start_date).to eq today + 3
    end

    it 'creates ConversationMessage' do
      expect(ConversationMessage.count).to eq 0
      patch academy_mentorship_session_path(mentorship_session), params: update_params
      expect(ConversationMessage.count).to eq 1
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys mentorship_session' do
      mentorship_session
      expect { delete academy_mentorship_session_path(mentorship_session) }.to change(MentorshipSession, :count).by(-1)
    end

    it 'creates a ConversationMessage' do
      mentorship_session
      expect(ConversationMessage.count).to eq 0
      delete academy_mentorship_session_path(mentorship_session)
      expect(ConversationMessage.count).to eq 1
    end
  end
end
