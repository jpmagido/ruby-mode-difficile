# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Staff::AnswersController', type: :request do
  let!(:answer) { create(:answer) }
  let!(:challenge) { create(:challenge) }
  let!(:user) { create(:user) }

  before { VCR.use_cassette('login') { post session_path } }

  describe 'GET /index' do
    it 'returns http success' do
      get staff_answers_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get staff_answers_path(answer)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_staff_answer_path(challenge_id: challenge.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:answer_params) do
      {
        answer: {
          github_url: 'https://github.com',
          youtube_url: 'https://youtube.com',
          signature: 'foobar',
          status: :ready,
          comments: 'I am foobar',
        },
        challenge_id: challenge.id,
      }
    end

    context 'when success' do
      it 'creates an Answer' do
        expect { post staff_answers_path, params: answer_params }.to change(Answer, :count).by 1
      end
    end

    context 'when error' do
      it 'renders new' do
        post staff_answers_path, params: { answer: { signature: '' } }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_staff_answer_path(answer)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    it 'updates answer' do
      patch staff_answer_path(answer), params: { answer: { signature: 'new signature' } }

      expect(answer.reload.signature).to eq 'new signature'
    end
  end

  describe 'DELETE /destroy' do
    it 'delete answer' do
      expect { delete staff_answer_path(answer) }.to change(Answer, :count).by(-1)
    end

    it 'redirects to answers index' do
      delete staff_answer_path(answer)
      expect(response).to redirect_to staff_answers_path
    end
  end
end
