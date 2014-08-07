class TasksController < ApplicationController
  def new
    @task_list = TaskList.find(params[:task_list_id])
    @task = Task.new(task_list_id: @task_list)
  end

  def create
    # binding.pry
    task = params[:task]
    date = Date.new(task["due_date(1i)"].to_i, task["due_date(2i)"].to_i, task["due_date(3i)"].to_i)
    @new_task = Task.new(description: params[:task][:description], due_date: date,task_list_id: params[:task_list_id].to_i)
    if @new_task.save
      flash[:notice] = "Task was created successfully!"
      redirect_to root_path
    else
      flash[:notice] = "Your task could not be created."
      @task = Task.new
      render :new
      # redirect_to new_task_path
    end

  end

  def completed
    id = params[:id]
    task = Task.find(id)
    task.update_attributes(completed: true)
    redirect_to root_path
  end

  def destroy
    id = params[:id]
    task = Task.find(id)
    task.delete
    flash[:notice] = "Task was deleted successfully!"
    redirect_to root_path
  end
end