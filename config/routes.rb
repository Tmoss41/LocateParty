Rails.application.routes.draw do
  get 'user_groups/add'
  devise_for :users, controllers: { sessions: 'users/sessions' }
  get 'user/:id', to: 'profiles#index', as: 'user'
  root to: 'home#index'
  resources :characters
  get 'user/:id/characters/new', to: 'characters#new', as: 'user_new_character'
  get 'groups', to: 'groups#index'
  get 'groups/find' , to: 'groups#find', as: 'find'
  post 'join', to: 'user_groups#join', as: 'join'
  get 'groups/new', to: 'groups#new', as: 'new_group'
  get 'group/:id' , to: 'groups#show', as: 'group'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
