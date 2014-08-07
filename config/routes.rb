Rails.application.routes.draw do
  # root "task_lists#index"
  # get "signin" => "sessions#new", as: :signin
  # post "signin" => "sessions#create"
  # get "signout" => "sessions#destroy", as: :signout
  #
  # get "abouts" => "abouts#show", as: :abouts


  # get "/task_list/:id" => "task_lists#show", as: :show_task_list
  # get "new" => "task_lists#new", as: :new_task_list
  # post "create" => "task_lists#create", as: :create_task_list
  # get "/edit/:id" => "task_lists#edit", as: :edit_task_list
  # patch "/update/:id" => "task_lists#update", as: :update_task_list
  # get "/task/new/:id" => "tasks#new", as: :new_task
  # post "/task/create/:id" => "tasks#create", as: :create_task
  # get "/task/delete/:id" => "tasks#delete", as: :delete_task
  # get "/task/completed/:id" => "tasks#completed", as: :completed_task

#   $ rake routes

#   Prefix Verb  URI Pattern                   Controller#Action
#   root GET   /                             task_lists#index
#   show_task_list GET   /task_list/:id(.:format)      task_lists#show
#   signin GET   /signin(.:format)             sessions#new
#          POST  /signin(.:format)             sessions#create
#   signout GET   /signout(.:format)            sessions#destroy

#   abouts GET   /abouts(.:format)             abouts#show

#   new_task_list GET   /new(.:format)                task_lists#new
#   create_task_list POST  /create(.:format)             task_lists#create
#   edit_task_list GET   /edit/:id(.:format)           task_lists#edit
#   update_task_list PATCH /update/:id(.:format)         task_lists#update

#   new_task GET   /task/new/:id(.:format)       tasks#new
#   create_task POST  /task/create/:id(.:format)    tasks#create
#   delete_task GET   /task/delete/:id(.:format)    tasks#delete
#   completed_task GET   /task/completed/:id(.:format) tasks#completed

  # resources :task_lists, :tasks
  # rake routes
  # Prefix Verb   URI Pattern                    Controller#Action
  # root           GET    /                              task_lists#index
  # show_task_list GET    /task_list/:id(.:format)       task_lists#show
  # signin         GET    /signin(.:format)              sessions#new
  #                POST   /signin(.:format)              sessions#create
  # signout        GET    /signout(.:format)             sessions#destroy
  # abouts         GET    /abouts(.:format)              abouts#show
  # task_lists     GET    /task_lists(.:format)          task_lists#index
  #                POST   /task_lists(.:format)          task_lists#create
  # new_task_list  GET    /task_lists/new(.:format)      task_lists#new
  # edit_task_list GET    /task_lists/:id/edit(.:format) task_lists#edit
  # task_list      GET    /task_lists/:id(.:format)      task_lists#show
  #                PATCH  /task_lists/:id(.:format)      task_lists#update
  #                PUT    /task_lists/:id(.:format)      task_lists#update
  #                DELETE /task_lists/:id(.:format)      task_lists#destroy
  # tasks          GET    /tasks(.:format)               tasks#index
  #                POST   /tasks(.:format)               tasks#create
  # new_task       GET    /tasks/new(.:format)           tasks#new
  # edit_task      GET    /tasks/:id/edit(.:format)      tasks#edit
  # task           GET    /tasks/:id(.:format)           tasks#show
  #                PATCH  /tasks/:id(.:format)           tasks#update
  #                PUT    /tasks/:id(.:format)           tasks#update
  #                DELETE /tasks/:id(.:format)           tasks#destroy


  root "task_lists#index"
  get "signin" => "sessions#new", as: :signin
  post "signin" => "sessions#create"
  get "signout" => "sessions#destroy", as: :signout

  get "abouts" => "abouts#show", as: :abouts

  resources :task_lists do
    resources :tasks
  end

  # rake routes
  # Prefix Verb         URI    Pattern                                        Controller#Action
  # root                GET    /                                                  task_lists#index
  # show_task_list      GET    /task_list/:id(.:format)                           task_lists#show
  # signin              GET    /signin(.:format)                                  sessions#new
  #                     POST   /signin(.:format)                                  sessions#create
  # signout             GET    /signout(.:format)                                 sessions#destroy
  # abouts              GET    /abouts(.:format)                                  abouts#show
  # task_list_tasks     GET    /task_lists/:task_list_id/tasks(.:format)          tasks#index

  # Change: use no path from new tasks form,
  # specify method: method="post"
  # post "/task/create/:id" => "tasks#create", as: :create_task
  #                     POST   /task_lists/:task_list_id/tasks(.:format)          tasks#create


  # done
  # Change: new_task_path(task_list.id) to new_task_list_task_path(task_list.id)
  # get "/task/new/:id" => "tasks#new", as: :new_task
  # new_task_list_task  GET    /task_lists/:task_list_id/tasks/new(.:format)      tasks#new
  # edit_task_list_task GET    /task_lists/:task_list_id/tasks/:id/edit(.:format) tasks#edit

  # task_list_task      GET    /task_lists/:task_list_id/tasks/:id(.:format)      tasks#show

  get "/task_list/:id/completed" => "task_lists#completed", as: :completed_task
  #                     PATCH  /task_lists/:task_list_id/tasks/:id(.:format)      tasks#update
  #                     PUT    /task_lists/:task_list_id/tasks/:id(.:format)      tasks#update

  # Change: use no path,
  # specify method: method="delete"
  # # get "/task/delete/:id" => "tasks#delete", as: :delete_task
  #                     DELETE /task_lists/:task_list_id/tasks/:id(.:format)      tasks#destroy
  # task_lists          GET    /task_lists(.:format)                              task_lists#index

  #
  # Change: use no path from new form,
  # specify method: method="post"
  # post "create" => "task_lists#create", as: :create_task_list
  #                     POST   /task_lists(.:format)                              task_lists#create

  # No change: new_task_list_path
  # get "new" => "task_lists#new", as: :new_task_list
  # new_task_list       GET    /task_lists/new(.:format)                          task_lists#new

  # No change: edit_task_list_path
  # get "/edit/:id" => "task_lists#edit", as: :edit_task_list
  # edit_task_list      GET    /task_lists/:id/edit(.:format)                     task_lists#edit

  # done
  # Change: show_task_list_path to task_list_path
  # get "/task_list/:id" => "task_lists#show", as: :show_task_list
  # task_list           GET    /task_lists/:id(.:format)                          task_lists#show

  # Change: use no path from edit form,
  # specify method: method="patch"
  # patch "/update/:id" => "task_lists#update", as: :update_task_list
  #                     PATCH  /task_lists/:id(.:format)                          task_lists#update
  #                     PUT    /task_lists/:id(.:format)                          task_lists#update
  #                     DELETE /task_lists/:id(.:format)                          task_lists#destroy

end
