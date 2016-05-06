Rails.application.routes.draw do
  root 'articles#index'

  resources :articles
  resources :authors

  mount Vital::Engine, at: "/components"
end
