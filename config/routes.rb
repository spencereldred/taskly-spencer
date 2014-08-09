Rails.application.routes.draw do

  root "task_lists#index"
  get "signin" => "sessions#new", as: :signin
  post "signin" => "sessions#create"
  get "signout" => "sessions#destroy", as: :signout

  get "abouts" => "abouts#show", as: :abouts

  resources :task_lists do
    resources :tasks
  end

  get "/task_list/:id/completed" => "task_lists#completed", as: :completed_task

end
