Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "posts#index"

  root "top#index"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  get "users/profile", to:  "users#show"
  delete "users/:id/delete_avatar", to: "users#delete_avatar", as: :delete_avatar

  resources :memories, only: %i[index new create show edit update destroy] do
    member do
      get "oneday"
    end
    collection do
      get "all"
    end

    resources :posts, only: %i[new create show edit update destroy]
  end

  resources :posts, only: %i[index]
end
