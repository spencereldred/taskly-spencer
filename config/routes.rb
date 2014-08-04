Rails.application.routes.draw do
  root "task_lists#index"
  get "signin" => "sessions#new", as: :signin
  post "signin" => "sessions#create"
  get "signout" => "sessions#destroy", as: :signout
  get "abouts" => "abouts#show", as: :abouts
  get "new" => "task_lists#new", as: :new_task_list
  post "create" => "task_lists#create", as: :create_task_list
end
