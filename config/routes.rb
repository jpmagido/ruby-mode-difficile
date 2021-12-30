# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'
  get 'static_pages/contact'

  resource :user, only: :show
  resource :session, only: %i[new edit create]

  resources :challenges, only: %i[index show new create]

  get 'errors/500'
end
