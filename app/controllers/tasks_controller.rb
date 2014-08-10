class TasksController < ApplicationController
  def new
    @task_list = TaskList.find(params[:task_list_id])
    @task = Task.new(task_list_id: @task_list)
    @users = User.all
  end

  def create
    task = params[:task]
    date = Date.new(task["due_date(1i)"].to_i, task["due_date(2i)"].to_i, task["due_date(3i)"].to_i)
    @new_task = Task.new(description: params[:task][:description], due_date: date,task_list_id: params[:task_list_id].to_i, assigned_to: params[:task][:assigned_to])
    if @new_task.save
      flash[:notice] = "Task was created successfully!"
      redirect_to root_path
    else
      flash[:notice] = "Your task could not be created - due date in the past."
      redirect_to new_task_list_task_path(params["task_list_id"])
    end
  end

  def update #completed task
    id = params[:id]
    task_list_id = params[:task_list_id]
    task = Task.find(id)
    task.update_attributes(completed: true)
    redirect_to completed_task_path(task_list_id)
  end

  def destroy
    id = params[:id]
    task = Task.find(id)
    task.delete
    flash[:notice] = "Task was deleted successfully!"
    redirect_to root_path
  end
end