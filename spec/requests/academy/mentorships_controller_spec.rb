# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Academy::MentorshipsController', type: :request do
  let(:current_user) { User.find_by_login('jpmagido') }
  let(:student) { create(:student, user: current_user) }
  let(:mentorship) { create(:mentorship, student: student) }

  before { VCR.use_cassette('login') { post session_path } }

  describe 'GET /show' do
    it 'returns http success' do
      get academy_mentorship_path(mentorship)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /index' do
    it 'returns http success' do
      mentorship
      get academy_mentorships_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_academy_mentorship_path(mentorship)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'creates a new Mentorship' do
      mentorship
      expect { post academy_mentorships_path, params: { coach_id: mentorship.coach_id } }
        .to change(current_user.student.mentorships, :count).by 1
    end

    it 'creates a new ConversationMessage' do
      mentorship
      expect { post academy_mentorships_path, params: { coach_id: mentorship.coach_id } }
        .to change(ConversationMessage, :count).by 1
    end
  end

  describe 'PATCH /update' do
    let(:update_params) { { mentorship: { student_approval: true } } }

    it 'updates Mentorship' do
      expect(mentorship.student_approval).to be_falsey
      patch academy_mentorship_path(mentorship), params: update_params
      expect(mentorship.reload.student_approval).to be_truthy
    end

    it 'creates ConversationMessage' do
      expect(ConversationMessage.count).to eq 0
      patch academy_mentorship_path(mentorship), params: update_params
      expect(ConversationMessage.count).to eq 1
    end
  end
end
