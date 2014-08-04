class TaskListsController < ApplicationController

  def index
    @task_lists = TaskList.order(:name)
  end

  def new
   @task_list = TaskList.new
  end

  def create
    tasklist = TaskList.create(name: params[:task_list][:name])
    if tasklist.save
      flash[:notice] = "Task List was created successfully!"
      @task_lists = TaskList.order(:name)
      render :index
    else
      render :new
    end

  end

end