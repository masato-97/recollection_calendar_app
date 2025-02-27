Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "posts#index"

  root "top#index"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  resources :memories do
    member do
      get "oneday"
    end
  end
end
