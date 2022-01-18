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
    resources :coaches, only: :new
    resources :conversations, only: %i[show create]
  end

  namespace :staff do
    resource :admin, only: :show
    resources :challenges do
      resources :answers
    end
    resources :answers, only: :index
    resources :users, only: %i[index show edit update destroy]
    resources :docs
    resources :doc_links, only: %i[new create destroy]
  end

  resource :session, only: %i[new edit create destroy]
  resource :locale, only: :update

  %w[500 401].each do |status|
    get "errors/#{status}"
  end
end
