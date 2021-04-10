class Api::V1::ProjectsController < ApplicationController
  def index
    render json: {
      projects: ProjectSerializer.new(current_user.projects)
    }
  end

  def create

    project = ProjectService.create(current_user,project_params)
    binding.pry
    json_response(project.to_json)
  end

  def show
    current_user.projects.find(params[:id])
  end

  def update
    current_user.projects.update project_params
  end

  def project_params
    params.require(:project).permit(
      :name, :description, :start_date, 
      :deadline, obstacles: [  :description ], 
      topic: [:uuid ] 
    )
  end
end

