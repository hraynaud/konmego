class Api::V1::ProjectsController < ApplicationController

  def create
    current_user.projects.create project_params
  end

  #TODO move consolidate search functionality in this controller or 
  #projexct_search_controller

  def search
    render json: ProjectSearchService.all_by_topic(params[:topic])
  end

  def project_params
    params.require(:project).permit(:name, :description, :start_date, :end_date, obstacles: [  :description ] )
  end
end

