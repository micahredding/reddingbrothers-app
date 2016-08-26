Rails.application.routes.draw do
  resources :releases, only: [:index, :show]
  resources :songs, only: [:index, :show]

  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => redirect('/releases')
end
