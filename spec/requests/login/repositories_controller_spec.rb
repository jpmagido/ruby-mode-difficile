# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login::RepositoriesController', type: :request do
  let(:repository) { create(:repository, cloud_storage: create(:challenge, user: current_user)) }
  let(:random_repository) { create(:repository, cloud_storage: create(:challenge)) }
  let(:current_user) { User.find_by_login 'jpmagido' }

  before { VCR.use_cassette('login') { post session_path } }

  context 'current_user updates own readme' do
    describe 'PATCH /update' do
      it 'updates readme' do
        VCR.use_cassette('github-api-repository-readme') do
          expect { patch login_repository_path(repository) }.to change { repository.reload.readme }
        end
      end
    end
  end

  context "current_user updates somebody's readme" do
    describe 'PATCH /update' do
      it 'updates readme' do
        VCR.use_cassette('github-api-repository-readme') do
          expect { patch login_repository_path(random_repository) }.to raise_error Pundit::NotAuthorizedError
        end
      end
    end
  end
end
