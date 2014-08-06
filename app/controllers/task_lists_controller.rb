class TaskListsController < ApplicationController

  def index
    @task_lists = TaskList.order(:name)
  end

  def show
    @task_list = TaskList.find(params[:id])
  end

  def new
   @task_list = TaskList.new
  end

  def create
    if params[:task_list][:name] != ""
      tasklist = TaskList.new(name: params[:task_list][:name])
      if tasklist.save
        flash[:notice] = "Task List was created successfully!"
        @task_lists = TaskList.order(:name)
        redirect_to root_path
      end
    else
      flash[:notice] = "Your task could not be created."
      redirect_to new_task_list_path
    end
  end

  def edit
    # binding.pry
    @task_list = TaskList.find(params[:id])
  end

  def update
    # binding.pry
    @task_list = TaskList.find(params[:id])

    if @task_list.update_attributes(name: params[:task_list][:name])
      flash[:notice] = "Task List was updated successfully!"
      redirect_to root_path
    else
      render :edit
    end
  end

end