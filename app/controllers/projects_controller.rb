class ProjectsController < ApplicationController

	before_action :authorize_manager, only: [:new, :create, :edit, :update, :destroy]

	before_action :check_developers_exists, only: [:create]

	def index
  	if @current_user.is_a?(Manager)
    	@projects = @current_user.projects
  	else
    	@projects = @current_user.assigned_projects
  	end
	end

  def show
  	@project = Project.find(params[:id])
  end

  def new 
  	@project = Project.new
  	@developers = Developer.all
  end

  def create
  	@project = @current_user.projects.new(project_params)

  	if @project.save
  		@project.developer_ids = params[:project][:developer_ids]
  		redirect_to @project
  	else
  		@developers = Developer.all
  		render :new, status: :unprocessable_entity
  	end
  end

  def edit
  	@project = Project.find(params[:id])
  	@developers = Developer.all
	end
	
	def update
  	@project = Project.find(params[:id])
  	if @project.update(project_params)
  		@project.developer_ids = params[:project][:developer_ids]
    	redirect_to @project
  	else
    	@developers = Developer.all
    	render :edit, status: :unprocessable_entity
  	end
	end

	def destroy
  	@project = Project.find(params[:id])
  	@project.destroy
  	redirect_to projects_path
	end

  private

  def project_params
  	params.require(:project).permit(:project_name, :start_date, :end_date, :status,
     developer_ids: [], avatars: [])
  end

  def check_developers_exists
    dev_ids = params[:project][:developer_ids]

    if dev_ids.blank?
      redirect_to new_project_path, alert: "No developer selected developer"
    end
  end

end
