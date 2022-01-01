# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'
  get 'static_pages/contact'

  namespace :login do
    resource :user, only: :show
    resources :challenges, only: %i[index show new create]
  end

  resource :session, only: %i[new edit create destroy]

  get 'errors/500'
end
