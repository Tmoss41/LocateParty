Rails.application.routes.draw do
  # Routes Relating to User Model and Signup Functions
  devise_for :users, controllers: { sessions: 'users/sessions' }
  get 'user/:id', to: 'profiles#index', as: 'user'
  # Root Page
  root to: 'home#index'
  # Routes Relating to the Characters CRUD Functionality
  resources :characters
  get 'user/:id/characters/new', to: 'characters#new', as: 'user_new_character'
  get 'user/:id/characters/edit', to: 'characters#edit', as: 'user_edit_character'
  delete 'user/:id/characters/delete', to: 'characters#delete', as: 'user_delete_character'

  # Routes Relating to the Group CRUD Functionality
  get 'groups', to: 'groups#index'
  post 'groups', to: 'groups#create'
  post 'groups/find' , to: 'groups#find', as: 'find'
  # post 'join', to: 'user_groups#join', as: 'join'
  get 'groups/new', to: 'groups#new', as: 'new_group'
  get 'group/:id' , to: 'groups#show', as: 'group'
  delete 'group/:id', to: 'groups#delete', as: 'delete_group'

  # Routes Relating to UserGroup Functionality, such as adding a new member to a group
  post 'join', to: 'user_groups#join', as: 'user_groups'
  post 'accepted_request', to: 'user_groups#approved', as: 'accept_request'
  patch 'accepted_request', to: 'user_groups#approved'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get 'games/new', to: 'games#new', as: 'games'
  # post 'games/new', to: 'games#create'
  # get 'games', to: 'games#index', as: 'games_list'
  # delete 'games/:id/delete', to: 'games#delete', as: 'games_delete_instance'
  # get 'games/:id/edit', to: 'games#edit', as: 'games_edit_instance'
  # post 'games/:id/edit', to: 'games#update'
  resources :games
end
