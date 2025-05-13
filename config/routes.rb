Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "posts#index"

  root "top#index"
  get "how_to_use", to: "top#how_to_use"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  get "users/profile", to: "users#show"
  get "users/setting", to: "users#set"
  delete "users/:id/delete_avatar", to: "users#delete_avatar", as: :delete_avatar

  resources :users do
    resource :reminder, only: %i[new create edit update]
  end

  resources :memories, only: %i[index new create show edit update destroy] do
    member do
      get "oneday"
    end
    collection do
      get "all"
      get "compare"
      get "search_tag", to: "memories#search_tag"
      get "search"
    end

    resources :posts, only: %i[new create show edit update destroy]
  end

  resources :posts, only: %i[index] do
    collection do
      get "search_tag", to: "posts#search_tag"
      get "search_mypost_tag", to: "posts#search_mypost_tag"
      get "search"
    end

    resource :favorites, only: %i[create destroy]
  end

  namespace :public do
    resources :inquiries, only: %i[new create] do
      collection do
        get "done"
      end
    end
  end
end
