class TasksController < ApplicationController
  include AllDevelopers

  before_action :authorize_manager, except: [ :index, :show ]
  before_action :set_project
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]
  before_action :show_all_developers

  def index
    @tasks = @project.tasks
  end

  def show
  end

  def new
    @task = @project.tasks.new
  end

  def create
    @task = @project.tasks.new(task_params)

    if @task.save
      @task.developer_ids = params.dig(:project, :developer_ids)
      redirect_to project_task_path(@project, @task)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      @task.developer_ids = params.dig(:project, :developer_ids)
      redirect_to project_task_path(@project, @task)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to project_tasks_path(@project)
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to project_tasks_path, alert: "Requested task does not exist"
  end

  def task_params
    params.require(:task).permit(:name, :description, :status, :priority, developer_ids: [])
  end

  def check_developers_exists?
    dev_ids = params.dig(:project, :developer_ids)
    if dev_ids.present?
      @developers = Developer.where(id: dev_ids)
      redirect_to new_project_path unless @developers.any?
    end
  end
end
