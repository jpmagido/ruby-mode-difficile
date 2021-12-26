# frozen_string_literal: true

Rails.application.routes.draw do
  resource :session, only: %i[new create show] do
    get 'temp_oauth'
  end

  root 'static_pages#home'
  get 'static_pages/contact'
  get 'oauth-redirect', to: 'static_pages#oauth'

  resources :challenges, only: %i[index show new create]
end
