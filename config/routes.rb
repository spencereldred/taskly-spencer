Rails.application.routes.draw do
  root "task_lists#index"
  get "/task_list/:id" => "task_lists#show", as: :show_task_list
  get "signin" => "sessions#new", as: :signin
  post "signin" => "sessions#create"
  get "signout" => "sessions#destroy", as: :signout
  get "abouts" => "abouts#show", as: :abouts
  get "new" => "task_lists#new", as: :new_task_list
  post "create" => "task_lists#create", as: :create_task_list
  get "/edit/:id" => "task_lists#edit", as: :edit_task_list
  patch "/update/:id" => "task_lists#update", as: :update_task_list
  get "/task/new/:id" => "tasks#new", as: :new_task
  post "/task/create/:id" => "tasks#create", as: :create_task
  get "/task/delete/:id" => "tasks#delete", as: :delete_task
  get "/task/completed/:id" => "tasks#completed", as: :completed_task
end
