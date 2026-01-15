class ProjectsController < ApplicationController
  include AllDevelopers

  before_action :set_project, except: [ :index, :new, :create ]
  before_action :authorize_manager, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :check_developers_exists?, only: [ :create ]

  def index
    @projects = @current_user.projects
  end

  def show
    @tasks = @project.tasks
  end

  def new
    @project = Project.new
  end

  def create
    @project = @current_user.projects.new(project_params)

    if @project.save
      @project.developer_ids = params.dig(:project, :developer_ids)

      redirect_to @project
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @project.update(project_params)
      @project.developer_ids = params.dig(:project, :developer_ids)
      redirect_to @project
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private

  def set_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to projects_path, alert: "Requested Project not found"
  end

  def project_params
    params.require(:project).permit(:name, :start_date, :end_date, :status, developer_ids: [], avatars: [])
  end

  def check_developers_exists?
    byebug
    dev_ids = params.dig(:project, :developer_ids)

    if dev_ids.blank?
      flash[:alert] = "No developers selected"
      redirect_to new_project_path
    else
      @developers = Developer.where(id: dev_ids)
      byebug
      @developers.each do |dev|
        if Developer.find_by(id: dev).blank?
          flash[:alert] = "Requested developer does not exits"
          return
        end
      end
    end
  end
end
