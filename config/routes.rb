# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'
  get 'static_pages/contact'

  namespace :login do
    resource :user, only: :show
    resources :challenges, only: %i[index show new create] do
      resources :answers, only: %i[show new create]
    end
    resources :repositories, only: :update
    resources :docs, only: %i[index show]
    resources :doc_links, only: %i[new create]
    resources :coaches, only: %i[new create]
    resources :conversations, only: %i[show create] do
      resources :conversation_messages, only: %i[new create]
    end
    resources :students, only: %i[new create]
  end

  namespace :staff do
    resource :admin, only: :show
    resources :challenges do
      resources :answers
    end
    resources :answers, only: :index
    resources :users, only: %i[index show edit update destroy]
    resources :docs
    resources :doc_links, only: %i[index new create destroy]
    resources :coaches, only: %i[index show edit update]
    resources :students, only: %i[index show edit update]
    resources :mentorships, only: %i[index show]
    resources :mentorship_sessions, only: %i[index show]
  end

  namespace :mentor do
    resource :coach, only: %i[show edit update]
    resources :students, only: %i[show index]
    resources :mentorships, only: %i[show index create edit update]
    resources :mentorship_sessions do
      resources :time_slots, only: %i[update]
    end
  end

  namespace :academy do
    resource :student, only: %i[show edit update]
    resources :mentorships, only: %i[show index create edit update]
    resources :mentorship_sessions do
      resources :time_slots, only: %i[update]
    end
  end

  resource :session, only: %i[new edit create destroy]
  resource :linkedin_session, only: %i[new edit]
  resource :locale, only: :update

  %w[500 401].each do |status|
    get "errors/#{status}"
  end
end
