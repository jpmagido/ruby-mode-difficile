# frozen_string_literal: true

Rails.application.routes.draw do
  resource :session, only: %i[new edit create show]

  root 'static_pages#home'
  get 'static_pages/contact'

  resources :users, only: %i[show]
  resources :challenges, only: %i[index show new create]

  get 'errors/500'
end
