# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'
  get 'static_pages/contact'

  namespace :login do
    resource :user, only: :show
    resources :challenges, only: %i[index show new create] do
      resources :answers, only: %i[show new create]
    end
  end

  namespace :staff do
    resource :admin, only: :show
    resources :challenges
    resources :answers
    resources :users, only: %i[index show edit update destroy]
  end

  resource :session, only: %i[new edit create destroy]

  %w[500 401].each do |status|
    get "errors/#{status}"
  end
end
