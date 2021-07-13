require 'sidekiq/web'

Rails.application.routes.draw do
  resources :reports, only: [:index, :create]
  mount Sidekiq::Web => '/sidekiq'
end
