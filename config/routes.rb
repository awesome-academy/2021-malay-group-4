Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("en|ja")}/ do
    root 'static_pages#home', as: "home"
    get 'static_pages/help', as: "help"

    get "/signup", to: "admin#new"
    post "/signup", to: "admin#create"

    resources :admin, only: %i(new create show)
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :account_activations, only: :edit
    resources :courses, only: [:create, :destroy]

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
  end
end
