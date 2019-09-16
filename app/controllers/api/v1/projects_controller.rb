class Api::V1::ProjectsController < ApplicationController

  def index
    projects = Project.all
    render json: projects.as_json 
  end

  def search
    render json: ProjectSearchService.all_by_topic(params[:topic])
  end

end

