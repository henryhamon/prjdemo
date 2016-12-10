class Api::V1::ProjectsController < BaseApiControllerController
  
  before_filter :find_project, only: [:show, :update, :destroy, :finish]

  def index
    render json: Project.active.order(created_at: :desc)
  end

  def show
    render json: @project
  end
  
	def create
		@project = Project.create(params[:project])
		if @project.valid?
		  render json: @project
		else
      render nothing: true, status: :bad_request
		end
	end

  def update
    @project.assign_attributes(params['project'])
    if @project.save
      render json: @project
    else
      render nothing: true, status: :bad_request
    end
  end

  def destroy
    @project.delete
    if @project.save
      render json: @project
    else
      render nothing: true, status: :bad_request
    end
  end
  
  def finish
    if @project.finish
      render json: @project
    else
      render nothing: true, status: :bad_request
    end
  end
  
  def finish_all
    projects = params[:projects]
    if !projects.empty?
      render json: projects
    else
      render nothing: true, status: :bad_request
    end
  end
  
 private
 def find_project
   @project = Project.find(params[:id])
   render nothing: true, status: :not_found unless @project.present? 
 end
 
end
