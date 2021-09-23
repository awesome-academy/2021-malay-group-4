Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ja/ do
    root 'static_pages#home'
    get 'static_pages/help'
  end
end
