Rails.application.routes.draw do
  resources :articles
  resources :authors

  mount Vital::Engine, at: "/components"
end
