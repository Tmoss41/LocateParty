Rails.application.routes.draw do
  get 'user_groups/add'
  devise_for :users, controllers: { sessions: 'users/sessions' }
  get 'user/:id', to: 'profiles#index', as: 'user'
  root to: 'home#index'
  resources :characters, :groups
  get 'user/:id/characters/new', to: 'characters#new', as: 'user_new_character'
  get 'groups', to: 'groups#index'
  get 'groups/find' , to: 'groups#find', as: 'find_group'
  post 'add', to: 'user_groups#add', as: 'user_add_to_group'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
