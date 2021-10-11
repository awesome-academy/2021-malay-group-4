Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ja/ do
    root "static_pages#home"
    get 'static_pages/help', as: "help"

    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    get "/courses", to: "courses#new"

    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :account_activations, only: :edit
    resources :registers
    resources :courses
  end
end
