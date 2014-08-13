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
    # if params[:task_list][:name] != ""
    @task_list = TaskList.new(name: params[:task_list][:name])
    if @task_list.save
      flash[:notice] = "Task List was created successfully!"
      @task_lists = TaskList.order(:name)
      redirect_to root_path
      # end
    else
      flash[:notice] = "Your task list could not be created."
      binding.pry
      render :new
    end
  end

  def edit
    @task_list = TaskList.find(params[:id])
  end

  def update
    @task_list = TaskList.find(params[:id])
    if @task_list.update_attributes(name: params[:task_list][:name])
      flash[:notice] = "Task List was updated successfully!"
      redirect_to root_path
    else
      render :edit
    end
  end

  def completed
    @task_list = TaskList.find(params[:id])
  end

  def destroy
    task_list = TaskList.find(params[:id])
    task_list.destroy
    flash[:notice] = "Task List was deleted successfully!"
    redirect_to root_path
  end

end