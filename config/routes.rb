Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ja/ do
    root 'static_pages#home', as: "home"
    get 'static_pages/help', as: "help"

    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users, only: %i(new create show)

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :account_activations, only: :edit

    get "/courseregister", to: "courses#new"
    post "/courseregister", to: "courses#create"
    resources :course, only: %i(new create show)
  end
end
