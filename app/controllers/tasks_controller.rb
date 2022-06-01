class TasksController < ApplicationController
before_action :authenticate_user!
  def new
    @categories = Category.all
  end

  def create
    @task = Task.create(task_params)
    @category = Category.find(category_params)
    @task.category = @category

    @task.save
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { }
    end
  end

  def edit
    @task = Task.find(params[:id])
    @categories = Category.all

  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)

    if params["checkbox-#{@task.id}"].nil?
      @task.update(status: false)
    else
      @task.update(status: true)
    end

    respond_to do |format|
      format.html { redirect_to tasks_path }
      format.js { }
    end
  end

  def index
    @tasks = Task.all
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { }
    end
  end


  private

  def task_params
    params.permit(:title, :deadline, :description)
  end

  def category_params
    params.require(:Category)
  end

end
