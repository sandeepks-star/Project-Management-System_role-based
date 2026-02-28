require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  
  # Defines the root path route ("/")
  root "projects#index"

  devise_for :users

  resources :projects do
    resources :tasks
  end

  mount Sidekiq::Web => '/sidekiq'

  # if Rails.env.development?
  #   mount LetterOpenerWeb::Engine, at: "/letter_opener"
  # end

end
