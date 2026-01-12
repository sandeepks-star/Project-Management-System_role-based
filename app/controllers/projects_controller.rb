class ProjectsController < ApplicationController

  before_action :find_project, except: [:index, :new, :create]

	before_action :authorize_manager, only: [:new, :create, :edit, :update, :destroy]

  before_action :show_all_developers, except: [:index, :show, :destroy]

	before_action :check_developers_exists, only: [:create]

	def index
    # add single line if condition - DONE
  	return @projects = @current_user.projects if @current_user.is_a?(Manager)
    @projects = @current_user.assigned_projects
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
  		@project.developer_ids = params[:project][:developer_ids]
  		redirect_to @project
  	else
  		render :new, status: :unprocessable_entity
  	end
  end

  def edit
    # Before action
	end
	
	def update
  	if @project.update(project_params)
  		@project.developer_ids = params[:project][:developer_ids]
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

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
  	params.require(:project).permit(:project_name, :start_date, :end_date, :status,
     developer_ids: [], avatars: [])
  end

  def check_developers_exists
    dev_ids = params[:project][:developer_ids]
    # One line if
    if dev_ids.blank?
      redirect_to new_project_path, alert: "No developer selected developer"
    end
  end

end
