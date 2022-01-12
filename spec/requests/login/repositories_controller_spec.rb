# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login::RepositoriesController', type: :request do
  let(:repository) { create(:repository, cloud_storage: create(:challenge)) }

  before { VCR.use_cassette('login') { post session_path } }

  describe 'PATCH /update' do
    it 'updates readme' do
      VCR.use_cassette('github-api-repository-readme') do
        expect { patch login_repository_path(repository) }.to change { repository.reload.readme }
      end
    end
  end
end
