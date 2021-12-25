Rails.application.routes.draw do
  root 'static_pages#home'
  get 'static_pages/contact'
  get 'oauth-redirect', to: 'static_pages#oauth'

  resources :challenges, only: %i[index show new create]
end
