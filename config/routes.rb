Rails.application.routes.draw do
  
  # Defines the root path route ("/")
  root "authentication#new"

  get "/login", to: "authentication#new", as: :new_login
  post "/login", to: "authentication#login", as: :login
  delete "/logout", to: "authentication#destroy", as: :logout

  get "/signup", to: "users#new", as: :users
  post "/signup", to: "users#create"

  resources :managers
  resources :developers

  resources :projects do
    resources :tasks
  end

  # if Rails.env.development?
  #   mount LetterOpenerWeb::Engine, at: "/letter_opener"
  # end

end
