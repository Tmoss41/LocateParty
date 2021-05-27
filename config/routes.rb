Rails.application.routes.draw do
  get 'locations/find'
  # Routes Relating to User Model and Signup Functions
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  get 'user/:id', to: 'profiles#show', as: 'user'
  # Root Page
  root to: 'home#index'
  # Routes Relating to the Characters CRUD Functionality
  resources :characters
  get 'user/:id/characters/new', to: 'characters#new', as: 'user_new_character'
  get 'user/:id/characters/edit', to: 'characters#edit', as: 'user_edit_character'
  delete 'characters/:id/delete', to: 'characters#delete', as: 'delete_character'
  get 'group/:id/find_user', to: 'profiles#find', as: 'find_profile'
  post 'group/:id/assign_admin', to: 'groups#make_admin', as: 'assign_admin'
  # Routes Relating to the Group CRUD Functionality
  post 'groups', to: 'groups#create'
  get 'groups/find' , to: 'groups#find', as: 'find'
  get 'groups/new', to: 'groups#new', as: 'new_group'
  get 'group/:id' , to: 'groups#show', as: 'group'
  delete 'group/:id', to: 'groups#delete', as: 'delete_group'
  get 'group/:id/edit' , to: 'groups#edit', as: 'edit_group'
  patch 'group/:id', to: 'groups#update'
  post 'group/:id/image_upload', to: 'groups#attach_image', as: 'group_image_upload'
  delete 'group/:id/delete_image', to: 'groups#destroy_image', as: 'delete_image'
  # Routes Relating to UserGroup Functionality, such as adding a new member to a group
  post 'join', to: 'user_groups#join', as: 'user_groups'
  post 'accept', to: 'user_groups#accept_invite', as: 'accept_invite'
  patch 'accept', to: 'user_groups#accept_invite'
  post 'accepted_request', to: 'user_groups#approved', as: 'accept_request'
  patch 'accepted_request', to: 'user_groups#approved'
  delete 'group/:id/delete_member', to: 'user_groups#destroy_member_in_group', as: 'delete_member'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'search', to: 'locations#find', as: 'nav_search'
  get '/404', to: 'errors#not_found'
  resources :games, :profiles
end
