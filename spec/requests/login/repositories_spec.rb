# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login::RepositoriesController', type: :request do
  let!(:repository) { create(:repository) }

  describe 'PATCH /update' do
    xit 'updates readme' do
      VCR.use_cassette('github-api-fetch-readme') do
        expect { patch login_repository_path(repository) }.to change(repository, :readme)
      end
    end
  end
end
