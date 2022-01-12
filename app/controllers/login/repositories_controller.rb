# frozen_string_literal: true

module Login
  class RepositoriesController < Login::BaseController

    def update
      if repository.update readme: readme
        flash[:success] = t('repositories.flashes.update-success')
      else
        flash[:error] = t('repositories.flashes.update-error', error: repository.errors.messages)
      end
      return redirect_to login_challenge_path(repository.cloud_storage) if repository.cloud_storage.is_a?(Challenge)

      redirect_to login_challenge_answer_path(repository.cloud_storage.challenge, repository.cloud_storage)
    end

    private

    def readme
      @readme ||= ::Github::Api::Repository.new(github_url: repository.github_url).readme
    end

    def repository
      @repository ||= Repository.find params[:id]
    end
  end
end
