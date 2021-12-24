Rails.application.routes.draw do
  root 'static_pages#home'
  get 'static_pages/contact'

  resources :challenges, only: %i[index show new create]
end
