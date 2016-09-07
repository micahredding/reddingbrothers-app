Rails.application.routes.draw do
  resources :releases, only: [:index, :show]
  resources :songs, only: [:index, :show]

  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root :to => redirect('/releases')
end
