# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login::ChallengesController', type: :request do
  let(:current_user) { User.find_by_login('jpmagido') }
  let(:challenge) { create(:challenge) }
  let(:challenge_params) do
    {
      challenge: {
        title: 'title test',
        duration: 20,
        difficulty: 3,
        signature: 'jpm',
        description: 'test description',
        repository: { github_url: 'https://www.google.fr' }
      }
    }
  end

  context 'User is not logged' do
    describe 'GET /index' do
      it 'returns http success' do
        get login_challenges_path
        expect(response).to redirect_to new_session_path
      end
    end
  end

  context 'User is logged' do
    before { VCR.use_cassette('login') { post session_path } }
    
    context 'User is logged as admin or coach' do
      before { create(:admin, user_id:current_user.id) }
      
      describe 'GET /index' do
        it 'returns http success' do
          get login_challenges_path
          expect(response).to have_http_status(:success)
        end
      end

      describe 'GET /show' do
        it 'returns http success' do
          get login_challenge_path(challenge)
          expect(response).to have_http_status(:success)
        end
      end

      describe 'GET /new' do
        it 'returns http success' do
          get new_login_challenge_path
          expect(response).to have_http_status(:success)
        end
      end

      describe 'POST /create' do

        context 'when success' do
          it 'creates a Challenge' do
            expect { post login_challenges_path, params: challenge_params }
              .to change(Challenge, :count).by 1
          end

          it 'redirects to show' do
            post login_challenges_path, params: challenge_params
            expect(response).to redirect_to login_challenge_path(Challenge.last)
          end

          it 'creates Challenge' do
            expect { post login_challenges_path, params: challenge_params }.to change(Challenge, :count).by 1
          end

          it 'creates Repository' do
            expect { post login_challenges_path, params: challenge_params }.to change(Repository, :count).by 1
          end
        end

        context 'when error' do
          it 'renders new' do
            post login_challenges_path, params: { challenge: { title: '' } }
            expect(response).to render_template :new
          end
        end

        context 'Admin and coach can create challenges' do
          it 'user as admin create challenges' do
            expect { post login_challenges_path, params: challenge_params }
              .to change(Challenge, :count).by 1
          end
        end
      end
    end

    context 'user is logged and he is neither admin nor coach' do
      it 'user can not create challenges' do
        expect { post login_challenges_path, params: challenge_params }
          .to_not change(Challenge, :count)
      end
    end 
  end
end
