class ProjectsController < ApplicationController
  include AllDevelopers

  before_action :set_project, except: [ :index, :new, :create ]
  before_action :authorize_manager!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :check_developers_exists?, only: [ :create, :update ]

  def index
    @projects = if current_user.manager?
                  current_user.managed_projects
                else
                  current_user.projects
                end
    @projects = @projects.filter_by_status(params[:status]) if params[:status].present?
    @projects = @projects.order(created_at: :desc)
  end

  def show
    @tasks = @project.tasks.order(created_at: :desc)
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.managed_projects.new(project_params)

    if @project.save
      @project.developer_ids = project_developer_ids

      redirect_to @project, notice: "Project created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @project.update(project_params)
      @project.developer_ids = project_developer_ids
      redirect_to @project, notice: "Project updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project deleted successfully"
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
    dev_ids = project_developer_ids

    if dev_ids.blank?
      redirect_back fallback_location: projects_path, alert: "Select at least one developer"
      return
    end

    invalid_ids = dev_ids.reject { |id| User.developer.exists?(id: id) }
    if invalid_ids.any?
      redirect_back fallback_location: projects_path, alert: "Invalid developer selected"
    end
  end

  def project_developer_ids
    params.dig(:project, :developer_ids).to_a.reject(&:blank?)
  end
end
